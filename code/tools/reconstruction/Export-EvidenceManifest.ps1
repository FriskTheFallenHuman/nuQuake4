param(
    [string]$RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")),
    [string]$OutputPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\evidence-manifest.json")
)

$ErrorActionPreference = "Stop"

$evidenceNames = @(
    "quake4.exe",
    "quake4.pdb",
    "quake4.c",
    "q4xbase\gamex86.dll"
)

$files = foreach ($name in $evidenceNames) {
    $path = Join-Path $RepositoryRoot $name
    $item = Get-Item -LiteralPath $path
    $hash = Get-FileHash -LiteralPath $path -Algorithm SHA256

    [ordered]@{
        path = $name.Replace("\", "/")
        bytes = $item.Length
        modifiedUtc = $item.LastWriteTimeUtc.ToString("o")
        sha256 = $hash.Hash.ToLowerInvariant()
    }
}

$manifest = [ordered]@{
    schemaVersion = 1
    generatedUtc = [DateTime]::UtcNow.ToString("o")
    target = [ordered]@{
        architecture = "x86"
        imageBase = "0x10000000"
        compiler = "Microsoft Visual C++ 13.10.3077"
        pdbGuid = "0F109363-54B5-494B-907D-0933AAE6B5D9"
        pdbAge = 119
    }
    files = $files
}

$json = $manifest | ConvertTo-Json -Depth 5
[IO.File]::WriteAllText($OutputPath, $json + [Environment]::NewLine, [Text.UTF8Encoding]::new($false))
Write-Output $OutputPath

