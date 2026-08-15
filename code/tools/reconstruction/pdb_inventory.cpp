/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

This file is part of the Quake 4 Reconstructed GPL Source Code (?Quake 4 Reconstructed Source Code?).

Quake 4 Reconstructed Source Code is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Quake 4 Reconstructed Source Code is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Quake 4 Reconstructed Source Code.  If not, see <http://www.gnu.org/licenses/>.

===========================================================================
*/

#include <windows.h>
#include <dia2.h>

#include <algorithm>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <map>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

namespace {

using DllGetClassObjectProc = HRESULT(STDAPICALLTYPE *)(REFCLSID, REFIID, LPVOID *);

template <typename T>
void Release(T *&value) {
    if (value != nullptr) {
        value->Release();
        value = nullptr;
    }
}

std::string Utf8(const wchar_t *text) {
    if (text == nullptr || *text == L'\0') {
        return {};
    }

    const int size = WideCharToMultiByte(CP_UTF8, 0, text, -1, nullptr, 0, nullptr, nullptr);
    std::string result(static_cast<size_t>(size), '\0');
    WideCharToMultiByte(CP_UTF8, 0, text, -1, result.data(), size, nullptr, nullptr);
    result.resize(static_cast<size_t>(size - 1));
    return result;
}

std::string SymbolString(IDiaSymbol *symbol, HRESULT(STDMETHODCALLTYPE IDiaSymbol::*getter)(BSTR *)) {
    BSTR value = nullptr;
    if (FAILED((symbol->*getter)(&value)) || value == nullptr) {
        return {};
    }
    const std::string result = Utf8(value);
    SysFreeString(value);
    return result;
}

std::string JsonEscape(const std::string &value) {
    std::ostringstream output;
    for (const unsigned char ch : value) {
        switch (ch) {
        case '\\': output << "\\\\"; break;
        case '"': output << "\\\""; break;
        case '\b': output << "\\b"; break;
        case '\f': output << "\\f"; break;
        case '\n': output << "\\n"; break;
        case '\r': output << "\\r"; break;
        case '\t': output << "\\t"; break;
        default:
            if (ch < 0x20) {
                output << "\\u" << std::hex << std::setw(4) << std::setfill('0')
                       << static_cast<unsigned int>(ch) << std::dec;
            } else {
                output << static_cast<char>(ch);
            }
            break;
        }
    }
    return output.str();
}

std::string HexRva(DWORD rva) {
    std::ostringstream output;
    output << "0x" << std::uppercase << std::hex << std::setw(8) << std::setfill('0') << rva;
    return output.str();
}

std::string GuidString(const GUID &guid) {
    wchar_t value[40] = {};
    StringFromGUID2(guid, value, static_cast<int>(std::size(value)));
    return Utf8(value);
}

std::string BasicTypeName(DWORD type, ULONGLONG length) {
    switch (type) {
    case btVoid: return "void";
    case btChar: return "char";
    case btWChar: return "wchar_t";
    case btInt:
        if (length == 1) return "signed char";
        if (length == 2) return "short";
        if (length == 8) return "__int64";
        return "int";
    case btUInt:
        if (length == 1) return "unsigned char";
        if (length == 2) return "unsigned short";
        if (length == 8) return "unsigned __int64";
        return "unsigned int";
    case btFloat: return length == 8 ? "double" : "float";
    case btBool: return "bool";
    case btLong: return "long";
    case btULong: return "unsigned long";
    case btCurrency: return "CURRENCY";
    case btDate: return "DATE";
    case btVariant: return "VARIANT";
    case btComplex: return "complex";
    case btBit: return "bit";
    case btBSTR: return "BSTR";
    case btHresult: return "HRESULT";
    default: return "<base-type-" + std::to_string(type) + ">";
    }
}

std::string TypeName(IDiaSymbol *symbol, int depth = 0) {
    if (symbol == nullptr || depth > 12) {
        return "<unknown>";
    }

    DWORD tag = SymTagNull;
    symbol->get_symTag(&tag);
    std::string result;

    if (tag == SymTagPointerType) {
        IDiaSymbol *pointee = nullptr;
        if (SUCCEEDED(symbol->get_type(&pointee)) && pointee != nullptr) {
            result = TypeName(pointee, depth + 1) + " *";
            Release(pointee);
        } else {
            result = "void *";
        }
    } else if (tag == SymTagArrayType) {
        IDiaSymbol *element = nullptr;
        DWORD count = 0;
        symbol->get_count(&count);
        if (SUCCEEDED(symbol->get_type(&element)) && element != nullptr) {
            result = TypeName(element, depth + 1);
            Release(element);
        } else {
            result = "<unknown>";
        }
        result += "[" + std::to_string(count) + "]";
    } else if (tag == SymTagBaseType) {
        DWORD baseType = btNoType;
        ULONGLONG length = 0;
        symbol->get_baseType(&baseType);
        symbol->get_length(&length);
        result = BasicTypeName(baseType, length);
    } else {
        result = SymbolString(symbol, &IDiaSymbol::get_name);
        if (result.empty()) {
            result = "<sym-tag-" + std::to_string(tag) + ">";
        }
    }

    BOOL isConst = FALSE;
    BOOL isVolatile = FALSE;
    symbol->get_constType(&isConst);
    symbol->get_volatileType(&isVolatile);
    if (isConst) result = "const " + result;
    if (isVolatile) result = "volatile " + result;
    return result;
}

std::string FindCompilandName(IDiaSymbol *symbol) {
    IDiaSymbol *current = symbol;
    current->AddRef();

    for (;;) {
        DWORD tag = SymTagNull;
        if (SUCCEEDED(current->get_symTag(&tag)) && tag == SymTagCompiland) {
            const std::string name = SymbolString(current, &IDiaSymbol::get_name);
            Release(current);
            return name;
        }

        IDiaSymbol *parent = nullptr;
        if (FAILED(current->get_lexicalParent(&parent)) || parent == nullptr) {
            Release(current);
            return {};
        }
        Release(current);
        current = parent;
    }
}

bool CreateDiaSource(const wchar_t *dllPath, HMODULE &module, IDiaDataSource *&source) {
    module = LoadLibraryW(dllPath);
    if (module == nullptr) {
        std::wcerr << L"Unable to load DIA provider " << dllPath << L" (" << GetLastError() << L")\n";
        return false;
    }

    const auto getClassObject = reinterpret_cast<DllGetClassObjectProc>(
        GetProcAddress(module, "DllGetClassObject"));
    if (getClassObject == nullptr) {
        std::cerr << "DIA provider does not export DllGetClassObject\n";
        return false;
    }

    IClassFactory *factory = nullptr;
    HRESULT hr = getClassObject(__uuidof(DiaSource), IID_IClassFactory,
                                reinterpret_cast<void **>(&factory));
    if (FAILED(hr)) {
        std::cerr << "Unable to obtain DIA class factory: 0x" << std::hex << hr << "\n";
        return false;
    }

    hr = factory->CreateInstance(nullptr, __uuidof(IDiaDataSource),
                                 reinterpret_cast<void **>(&source));
    factory->Release();
    if (FAILED(hr)) {
        std::cerr << "Unable to create DIA data source: 0x" << std::hex << hr << "\n";
        return false;
    }
    return true;
}

void WriteCompilands(std::ostream &output, IDiaSymbol *global) {
    IDiaEnumSymbols *symbols = nullptr;
    global->findChildren(SymTagCompiland, nullptr, nsNone, &symbols);

    output << "  \"compilands\": [\n";
    bool first = true;
    if (symbols != nullptr) {
        IDiaSymbol *symbol = nullptr;
        ULONG fetched = 0;
        while (symbols->Next(1, &symbol, &fetched) == S_OK && fetched == 1) {
            if (!first) output << ",\n";
            first = false;
            output << "    {\"name\": \""
                   << JsonEscape(SymbolString(symbol, &IDiaSymbol::get_name)) << "\"}";
            Release(symbol);
        }
    }
    output << "\n  ],\n";
    Release(symbols);
}

void WriteSourceFiles(std::ostream &output, IDiaSession *session) {
    IDiaEnumSourceFiles *files = nullptr;
    session->findFile(nullptr, nullptr, nsNone, &files);

    std::set<std::string> names;
    if (files != nullptr) {
        IDiaSourceFile *file = nullptr;
        ULONG fetched = 0;
        while (files->Next(1, &file, &fetched) == S_OK && fetched == 1) {
            BSTR value = nullptr;
            if (SUCCEEDED(file->get_fileName(&value)) && value != nullptr) {
                names.insert(Utf8(value));
                SysFreeString(value);
            }
            Release(file);
        }
    }
    Release(files);

    output << "  \"sourceFiles\": [\n";
    bool first = true;
    for (const auto &name : names) {
        if (!first) output << ",\n";
        first = false;
        output << "    \"" << JsonEscape(name) << "\"";
    }
    output << "\n  ],\n";
}

void WriteFunctions(std::ostream &output, IDiaSymbol *global) {
    IDiaEnumSymbols *compilands = nullptr;
    global->findChildren(SymTagCompiland, nullptr, nsNone, &compilands);

    output << "  \"functions\": [\n";
    bool first = true;
    if (compilands != nullptr) {
        IDiaSymbol *compiland = nullptr;
        ULONG compilandFetched = 0;
        while (compilands->Next(1, &compiland, &compilandFetched) == S_OK && compilandFetched == 1) {
            const std::string compilandName = SymbolString(compiland, &IDiaSymbol::get_name);
            IDiaEnumSymbols *symbols = nullptr;
            compiland->findChildren(SymTagFunction, nullptr, nsNone, &symbols);

            if (symbols != nullptr) {
                IDiaSymbol *symbol = nullptr;
                ULONG fetched = 0;
                while (symbols->Next(1, &symbol, &fetched) == S_OK && fetched == 1) {
                    DWORD rva = 0;
                    if (FAILED(symbol->get_relativeVirtualAddress(&rva))) {
                        Release(symbol);
                        continue;
                    }

                    DWORD id = 0;
                    ULONGLONG length = 0;
                    symbol->get_symIndexId(&id);
                    symbol->get_length(&length);

                    if (!first) output << ",\n";
                    first = false;
                    output << "    {\"id\": " << id
                           << ", \"rva\": " << rva
                           << ", \"rvaHex\": \"" << HexRva(rva) << "\""
                           << ", \"length\": " << length
                           << ", \"name\": \"" << JsonEscape(SymbolString(symbol, &IDiaSymbol::get_name)) << "\""
                           << ", \"undecoratedName\": \""
                           << JsonEscape(SymbolString(symbol, &IDiaSymbol::get_undecoratedName)) << "\""
                           << ", \"compiland\": \"" << JsonEscape(compilandName) << "\"}";
                    Release(symbol);
                }
            }
            Release(symbols);
            Release(compiland);
        }
    }
    output << "\n  ],\n";
    Release(compilands);
}

void WriteData(std::ostream &output, IDiaSymbol *global) {
    IDiaEnumSymbols *symbols = nullptr;
    global->findChildren(SymTagData, nullptr, nsNone, &symbols);

    output << "  \"data\": [\n";
    bool first = true;
    if (symbols != nullptr) {
        IDiaSymbol *symbol = nullptr;
        ULONG fetched = 0;
        while (symbols->Next(1, &symbol, &fetched) == S_OK && fetched == 1) {
            DWORD rva = 0;
            DWORD id = 0;
            DWORD kind = 0;
            symbol->get_symIndexId(&id);
            symbol->get_dataKind(&kind);
            const bool hasRva = SUCCEEDED(symbol->get_relativeVirtualAddress(&rva));

            if (!first) output << ",\n";
            first = false;
            output << "    {\"id\": " << id
                   << ", \"name\": \"" << JsonEscape(SymbolString(symbol, &IDiaSymbol::get_name)) << "\""
                   << ", \"dataKind\": " << kind;
            if (hasRva) {
                output << ", \"rva\": " << rva << ", \"rvaHex\": \"" << HexRva(rva) << "\"";
            }
            output << "}";
            Release(symbol);
        }
    }
    output << "\n  ],\n";
    Release(symbols);
}

void WriteUserDefinedTypes(std::ostream &output, IDiaSymbol *global) {
    IDiaEnumSymbols *symbols = nullptr;
    global->findChildren(SymTagUDT, nullptr, nsNone, &symbols);

    std::set<std::pair<std::string, ULONGLONG>> types;
    if (symbols != nullptr) {
        IDiaSymbol *symbol = nullptr;
        ULONG fetched = 0;
        while (symbols->Next(1, &symbol, &fetched) == S_OK && fetched == 1) {
            ULONGLONG length = 0;
            symbol->get_length(&length);
            types.emplace(SymbolString(symbol, &IDiaSymbol::get_name), length);
            Release(symbol);
        }
    }
    Release(symbols);

    output << "  \"userDefinedTypes\": [\n";
    bool first = true;
    for (const auto &[name, length] : types) {
        if (!first) output << ",\n";
        first = false;
        output << "    {\"name\": \"" << JsonEscape(name) << "\", \"length\": " << length << "}";
    }
    output << "\n  ],\n";
}

struct TypeMemberRecord {
    std::string name;
    std::string type;
    LONG offset = 0;
    ULONGLONG length = 0;
    DWORD access = 0;
};

struct BaseClassRecord {
    std::string type;
    LONG offset = 0;
    DWORD access = 0;
};

struct TypeLayoutRecord {
    std::string name;
    ULONGLONG length = 0;
    DWORD kind = 0;
    std::vector<BaseClassRecord> bases;
    std::vector<TypeMemberRecord> members;
};

void WriteTypeLayouts(std::ostream &output, IDiaSymbol *global) {
    IDiaEnumSymbols *symbols = nullptr;
    global->findChildren(SymTagUDT, nullptr, nsNone, &symbols);

    std::map<std::pair<std::string, ULONGLONG>, TypeLayoutRecord> layouts;
    if (symbols != nullptr) {
        IDiaSymbol *symbol = nullptr;
        ULONG fetched = 0;
        while (symbols->Next(1, &symbol, &fetched) == S_OK && fetched == 1) {
            ULONGLONG length = 0;
            DWORD kind = 0;
            symbol->get_length(&length);
            symbol->get_udtKind(&kind);
            const std::string name = SymbolString(symbol, &IDiaSymbol::get_name);
            const auto key = std::make_pair(name, length);
            auto [position, inserted] = layouts.emplace(key, TypeLayoutRecord{});
            TypeLayoutRecord &layout = position->second;
            if (inserted) {
                layout.name = name;
                layout.length = length;
                layout.kind = kind;
            }

            if (layout.members.empty()) {
                IDiaEnumSymbols *members = nullptr;
                symbol->findChildren(SymTagData, nullptr, nsNone, &members);
                if (members != nullptr) {
                    IDiaSymbol *member = nullptr;
                    ULONG memberFetched = 0;
                    while (members->Next(1, &member, &memberFetched) == S_OK && memberFetched == 1) {
                        DWORD dataKind = DataIsUnknown;
                        member->get_dataKind(&dataKind);
                        if (dataKind == DataIsMember) {
                            TypeMemberRecord record;
                            record.name = SymbolString(member, &IDiaSymbol::get_name);
                            member->get_offset(&record.offset);
                            member->get_access(&record.access);
                            IDiaSymbol *type = nullptr;
                            if (SUCCEEDED(member->get_type(&type)) && type != nullptr) {
                                record.type = TypeName(type);
                                type->get_length(&record.length);
                                Release(type);
                            }
                            layout.members.push_back(std::move(record));
                        }
                        Release(member);
                    }
                }
                Release(members);
            }

            if (layout.bases.empty()) {
                IDiaEnumSymbols *bases = nullptr;
                symbol->findChildren(SymTagBaseClass, nullptr, nsNone, &bases);
                if (bases != nullptr) {
                    IDiaSymbol *base = nullptr;
                    ULONG baseFetched = 0;
                    while (bases->Next(1, &base, &baseFetched) == S_OK && baseFetched == 1) {
                        BaseClassRecord record;
                        base->get_offset(&record.offset);
                        base->get_access(&record.access);
                        IDiaSymbol *type = nullptr;
                        if (SUCCEEDED(base->get_type(&type)) && type != nullptr) {
                            record.type = TypeName(type);
                            Release(type);
                        } else {
                            record.type = SymbolString(base, &IDiaSymbol::get_name);
                        }
                        layout.bases.push_back(std::move(record));
                        Release(base);
                    }
                }
                Release(bases);
            }
            Release(symbol);
        }
    }
    Release(symbols);

    output << "  \"typeLayouts\": [\n";
    bool firstLayout = true;
    for (const auto &[key, layout] : layouts) {
        if (layout.members.empty() && layout.bases.empty()) continue;
        if (!firstLayout) output << ",\n";
        firstLayout = false;
        output << "    {\"name\": \"" << JsonEscape(layout.name)
               << "\", \"length\": " << layout.length
               << ", \"kind\": " << layout.kind
               << ", \"bases\": [";
        bool firstBase = true;
        for (const auto &base : layout.bases) {
            if (!firstBase) output << ", ";
            firstBase = false;
            output << "{\"type\": \"" << JsonEscape(base.type)
                   << "\", \"offset\": " << base.offset
                   << ", \"access\": " << base.access << "}";
        }
        output << "], \"members\": [";
        bool firstMember = true;
        for (const auto &member : layout.members) {
            if (!firstMember) output << ", ";
            firstMember = false;
            output << "{\"name\": \"" << JsonEscape(member.name)
                   << "\", \"type\": \"" << JsonEscape(member.type)
                   << "\", \"offset\": " << member.offset
                   << ", \"length\": " << member.length
                   << ", \"access\": " << member.access << "}";
        }
        output << "]}";
    }
    output << "\n  ]\n";
}

} // namespace

int wmain(int argc, wchar_t **argv) {
    if (argc != 4) {
        std::wcerr << L"usage: q4_pdb_inventory <msdia140.dll> <input.pdb> <output.json>\n";
        return 2;
    }

    HRESULT hr = CoInitializeEx(nullptr, COINIT_MULTITHREADED);
    if (FAILED(hr)) {
        std::cerr << "CoInitializeEx failed: 0x" << std::hex << hr << "\n";
        return 1;
    }

    HMODULE diaModule = nullptr;
    IDiaDataSource *source = nullptr;
    IDiaSession *session = nullptr;
    IDiaSymbol *global = nullptr;

    if (!CreateDiaSource(argv[1], diaModule, source)) {
        CoUninitialize();
        return 1;
    }

    hr = source->loadDataFromPdb(argv[2]);
    if (SUCCEEDED(hr)) hr = source->openSession(&session);
    if (SUCCEEDED(hr)) hr = session->get_globalScope(&global);
    if (FAILED(hr)) {
        std::cerr << "Unable to open PDB: 0x" << std::hex << hr << "\n";
        Release(global);
        Release(session);
        Release(source);
        FreeLibrary(diaModule);
        CoUninitialize();
        return 1;
    }

    std::ofstream output(std::filesystem::path(argv[3]), std::ios::binary | std::ios::trunc);
    if (!output) {
        std::wcerr << L"Unable to create " << argv[3] << L"\n";
        Release(global);
        Release(session);
        Release(source);
        FreeLibrary(diaModule);
        CoUninitialize();
        return 1;
    }

    GUID guid = {};
    DWORD age = 0;
    global->get_guid(&guid);
    global->get_age(&age);

    output << "{\n"
           << "  \"schemaVersion\": 2,\n"
           << "  \"pdb\": {\"guid\": \"" << JsonEscape(GuidString(guid))
           << "\", \"age\": " << age << "},\n";
    WriteCompilands(output, global);
    WriteSourceFiles(output, session);
    WriteFunctions(output, global);
    WriteData(output, global);
    WriteUserDefinedTypes(output, global);
    WriteTypeLayouts(output, global);
    output << "}\n";

    Release(global);
    Release(session);
    Release(source);
    FreeLibrary(diaModule);
    CoUninitialize();
    return 0;
}
