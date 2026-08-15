#!/usr/bin/env python3
"""Extract rebuildable visual resources from a Windows PE image.

The Quake 4 reconstruction keeps the retail executable and tools DLL as
evidence.  This script turns their RT_GROUP_ICON, RT_GROUP_CURSOR and
RT_BITMAP resources into ordinary .ico, .cur and .bmp files without requiring
Resource Hacker, pefile, or another third-party package.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import struct
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator


RT_BITMAP = 2
RT_ICON = 3
RT_CURSOR = 1
RT_GROUP_CURSOR = 12
RT_GROUP_ICON = 14


@dataclass(frozen=True)
class Resource:
    type_name: str
    name: str
    language: str
    data: bytes
    rva: int


class PEImage:
    def __init__(self, path: Path) -> None:
        self.path = path
        self.data = path.read_bytes()
        pe_offset = struct.unpack_from("<I", self.data, 0x3C)[0]
        if self.data[pe_offset : pe_offset + 4] != b"PE\0\0":
            raise ValueError(f"{path} is not a PE image")

        section_count = struct.unpack_from("<H", self.data, pe_offset + 6)[0]
        optional_size = struct.unpack_from("<H", self.data, pe_offset + 20)[0]
        optional_offset = pe_offset + 24
        magic = struct.unpack_from("<H", self.data, optional_offset)[0]
        if magic == 0x10B:
            data_directory_offset = optional_offset + 96
        elif magic == 0x20B:
            data_directory_offset = optional_offset + 112
        else:
            raise ValueError(f"unsupported PE optional-header magic 0x{magic:04x}")

        self.resource_rva, self.resource_size = struct.unpack_from(
            "<II", self.data, data_directory_offset + 2 * 8
        )
        if not self.resource_rva:
            raise ValueError(f"{path} has no resource directory")

        section_offset = optional_offset + optional_size
        self.sections: list[tuple[int, int, int]] = []
        for index in range(section_count):
            offset = section_offset + index * 40
            virtual_size, virtual_address, raw_size, raw_pointer = struct.unpack_from(
                "<IIII", self.data, offset + 8
            )
            self.sections.append(
                (virtual_address, max(virtual_size, raw_size), raw_pointer)
            )
        self.resource_offset = self.rva_to_offset(self.resource_rva)

    def rva_to_offset(self, rva: int) -> int:
        for virtual_address, size, raw_pointer in self.sections:
            if virtual_address <= rva < virtual_address + size:
                return raw_pointer + rva - virtual_address
        raise ValueError(f"RVA 0x{rva:08x} is outside the PE sections")

    def _entry_name(self, value: int) -> str:
        if value & 0x80000000:
            offset = self.resource_offset + (value & 0x7FFFFFFF)
            length = struct.unpack_from("<H", self.data, offset)[0]
            start = offset + 2
            return self.data[start : start + length * 2].decode("utf-16le")
        return str(value)

    def resources(self) -> Iterator[Resource]:
        def walk(relative_offset: int, components: list[str]) -> Iterator[Resource]:
            offset = self.resource_offset + relative_offset
            named_count, id_count = struct.unpack_from("<HH", self.data, offset + 12)
            for index in range(named_count + id_count):
                name, child = struct.unpack_from("<II", self.data, offset + 16 + index * 8)
                child_components = components + [self._entry_name(name)]
                if child & 0x80000000:
                    yield from walk(child & 0x7FFFFFFF, child_components)
                    continue

                data_entry = self.resource_offset + child
                rva, size, _codepage, _reserved = struct.unpack_from(
                    "<IIII", self.data, data_entry
                )
                data_offset = self.rva_to_offset(rva)
                padded = child_components + ["0", "0", "0"]
                yield Resource(
                    padded[0],
                    padded[1],
                    padded[2],
                    self.data[data_offset : data_offset + size],
                    rva,
                )

        yield from walk(0, [])


def safe_name(value: str) -> str:
    cleaned = re.sub(r"[^A-Za-z0-9_.-]+", "_", value).strip("._")
    return cleaned or "unnamed"


def choose_resource(
    index: dict[tuple[str, str], list[Resource]], type_id: int, resource_id: int, language: str
) -> Resource:
    candidates = index.get((str(type_id), str(resource_id)), [])
    if not candidates:
        raise KeyError(f"missing resource type {type_id}, id {resource_id}")
    for candidate in candidates:
        if candidate.language == language:
            return candidate
    return candidates[0]


def build_icon(
    group: Resource, index: dict[tuple[str, str], list[Resource]]
) -> bytes:
    reserved, icon_type, count = struct.unpack_from("<HHH", group.data, 0)
    if reserved != 0 or icon_type != 1:
        raise ValueError(f"invalid group icon {group.name}")

    directory = bytearray(struct.pack("<HHH", 0, 1, count))
    images: list[bytes] = []
    image_offset = 6 + count * 16
    for item in range(count):
        entry = struct.unpack_from("<BBBBHHIH", group.data, 6 + item * 14)
        width, height, colors, _reserved, planes, bits, _size, resource_id = entry
        image = choose_resource(index, RT_ICON, resource_id, group.language).data
        directory.extend(
            struct.pack(
                "<BBBBHHII",
                width,
                height,
                colors,
                0,
                planes,
                bits,
                len(image),
                image_offset,
            )
        )
        images.append(image)
        image_offset += len(image)
    return bytes(directory) + b"".join(images)


def build_cursor(
    group: Resource, index: dict[tuple[str, str], list[Resource]]
) -> bytes:
    reserved, cursor_type, count = struct.unpack_from("<HHH", group.data, 0)
    if reserved != 0 or cursor_type != 2:
        raise ValueError(f"invalid group cursor {group.name}")

    directory = bytearray(struct.pack("<HHH", 0, 2, count))
    images: list[bytes] = []
    image_offset = 6 + count * 16
    for item in range(count):
        width, height, _planes, _bits, _size, resource_id = struct.unpack_from(
            "<HHHHIH", group.data, 6 + item * 14
        )
        resource = choose_resource(index, RT_CURSOR, resource_id, group.language).data
        if len(resource) < 4:
            raise ValueError(f"cursor resource {resource_id} is too small")
        hotspot_x, hotspot_y = struct.unpack_from("<HH", resource, 0)
        image = resource[4:]
        directory.extend(
            struct.pack(
                "<BBBBHHII",
                width & 0xFF,
                height & 0xFF,
                0,
                0,
                hotspot_x,
                hotspot_y,
                len(image),
                image_offset,
            )
        )
        images.append(image)
        image_offset += len(image)
    return bytes(directory) + b"".join(images)


def build_bitmap(dib: bytes) -> bytes:
    if len(dib) < 16:
        raise ValueError("bitmap resource is too small")
    header_size = struct.unpack_from("<I", dib, 0)[0]
    mask_size = 0
    if header_size == 12:
        bit_count = struct.unpack_from("<H", dib, 10)[0]
        palette_entry_size = 3
        color_count = 1 << bit_count if bit_count <= 8 else 0
    elif header_size >= 40:
        bit_count = struct.unpack_from("<H", dib, 14)[0]
        compression = struct.unpack_from("<I", dib, 16)[0]
        color_count = struct.unpack_from("<I", dib, 32)[0]
        if not color_count and bit_count <= 8:
            color_count = 1 << bit_count
        palette_entry_size = 4
        if header_size == 40 and compression == 3:
            mask_size = 12
        elif header_size == 40 and compression == 6:
            mask_size = 16
    else:
        raise ValueError(f"unsupported DIB header size {header_size}")

    pixel_offset = 14 + header_size + mask_size + color_count * palette_entry_size
    file_size = 14 + len(dib)
    return struct.pack("<2sIHHI", b"BM", file_size, 0, 0, pixel_offset) + dib


def extract(source: Path, output_root: Path) -> dict[str, object]:
    image = PEImage(source)
    resources = list(image.resources())
    index: dict[tuple[str, str], list[Resource]] = {}
    for resource in resources:
        index.setdefault((resource.type_name, resource.name), []).append(resource)

    source_output = output_root / safe_name(source.stem.lower())
    emitted: list[dict[str, object]] = []

    for resource in resources:
        kind: str | None = None
        extension: str | None = None
        payload: bytes | None = None
        if resource.type_name == str(RT_GROUP_ICON):
            kind, extension = "icons", ".ico"
            payload = build_icon(resource, index)
        elif resource.type_name == str(RT_GROUP_CURSOR):
            kind, extension = "cursors", ".cur"
            payload = build_cursor(resource, index)
        elif resource.type_name == str(RT_BITMAP):
            kind, extension = "bitmaps", ".bmp"
            payload = build_bitmap(resource.data)
        if payload is None or kind is None or extension is None:
            continue

        relative = Path(kind) / f"{safe_name(resource.name)}_{safe_name(resource.language)}{extension}"
        destination = source_output / relative
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(payload)
        emitted.append(
            {
                "resource_type": resource.type_name,
                "resource_name": resource.name,
                "language": resource.language,
                "rva": f"0x{resource.rva:08x}",
                "path": relative.as_posix(),
                "size": len(payload),
                "sha256": hashlib.sha256(payload).hexdigest(),
            }
        )

    manifest = {
        "source": str(source.resolve()),
        "source_size": source.stat().st_size,
        "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
        "resource_directory_rva": f"0x{image.resource_rva:08x}",
        "resource_directory_size": image.resource_size,
        "emitted": emitted,
    }
    manifest_path = source_output / "manifest.json"
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    return manifest


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("sources", nargs="+", type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    for source in args.sources:
        manifest = extract(source, args.output)
        print(f"{source}: emitted {len(manifest['emitted'])} visual resources")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
