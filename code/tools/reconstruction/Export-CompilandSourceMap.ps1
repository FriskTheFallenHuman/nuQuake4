param(
    [string]$PdbInventoryPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\pdb-inventory.json"),
    [string]$SourceRoot = (Join-Path $PSScriptRoot "..\.."),
    [string]$OutputPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\compiland-source-map.csv")
)

$ErrorActionPreference = "Stop"

$inventory = Get-Content -LiteralPath $PdbInventoryPath -Raw | ConvertFrom-Json
$sourceRootPath = (Resolve-Path -LiteralPath $SourceRoot).Path

$sourceByStem = @{}
Get-ChildItem -LiteralPath $sourceRootPath -Recurse -File |
    Where-Object {
        $_.Extension -in @(".c", ".cc", ".cpp", ".cxx") -and
        $_.FullName -notmatch "[\\/]out[\\/]"
    } |
    ForEach-Object {
        $stem = $_.BaseName.ToLowerInvariant()
        if (-not $sourceByStem.ContainsKey($stem)) {
            $sourceByStem[$stem] = [Collections.Generic.List[string]]::new()
        }
        $relative = $_.FullName.Substring($sourceRootPath.Length).TrimStart("\", "/").Replace("\", "/")
        $sourceByStem[$stem].Add($relative)
    }

$pdbSourceByStem = @{}
foreach ($sourceFile in $inventory.sourceFiles) {
    $path = if ($sourceFile -is [string]) { $sourceFile } else { $sourceFile.name }
    if (-not $path) { continue }
    $extension = [IO.Path]::GetExtension($path).ToLowerInvariant()
    if ($extension -notin @(".c", ".cc", ".cpp", ".cxx")) { continue }
    $stem = [IO.Path]::GetFileNameWithoutExtension($path).ToLowerInvariant()
    if (-not $pdbSourceByStem.ContainsKey($stem)) {
        $pdbSourceByStem[$stem] = [Collections.Generic.List[string]]::new()
    }
    if (-not $pdbSourceByStem[$stem].Contains($path)) {
        $pdbSourceByStem[$stem].Add($path)
    }
}

$functionCounts = @{}
foreach ($function in $inventory.functions) {
    if (-not $function.compiland) { continue }
    if (-not $functionCounts.ContainsKey($function.compiland)) {
        $functionCounts[$function.compiland] = 0
    }
    $functionCounts[$function.compiland]++
}

$rows = foreach ($compilandEntry in $inventory.compilands) {
    $compiland = if ($compilandEntry -is [string]) { $compilandEntry } else { $compilandEntry.name }
    $stem = [IO.Path]::GetFileNameWithoutExtension($compiland).ToLowerInvariant()
    $sources = if ($sourceByStem.ContainsKey($stem)) { @($sourceByStem[$stem] | Sort-Object -Unique) } else { @() }
    $pdbSources = if ($pdbSourceByStem.ContainsKey($stem)) { @($pdbSourceByStem[$stem] | Sort-Object -Unique) } else { @() }

    [pscustomobject]@{
        compiland = $compiland
        objectStem = $stem
        pdbSource = $pdbSources -join " | "
        reconstructedSource = $sources -join " | "
        mappingStatus = if ($sources.Count -eq 0) { "missing" } elseif ($sources.Count -eq 1) { "mapped-one" } else { "mapped-many" }
        pdbFunctionCount = if ($functionCounts.ContainsKey($compiland)) { $functionCounts[$compiland] } else { 0 }
    }
}

$rows |
    Sort-Object compiland |
    Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding UTF8

$summary = $rows | Group-Object mappingStatus | Sort-Object Name
$summary | ForEach-Object { "{0}: {1}" -f $_.Name, $_.Count }
