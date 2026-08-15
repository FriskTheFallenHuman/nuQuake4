param(
    [string]$RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")),
    [string]$PdbInventoryPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\pdb-inventory.json"),
    [string]$ImplementationMapPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\implementation-map.csv"),
    [string]$LedgerPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\function-ledger.csv"),
    [string]$SummaryPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\function-ledger-summary.json")
)

$ErrorActionPreference = "Stop"
$imageBase = [uint64]0x10000000
$hexRaysPath = Join-Path $RepositoryRoot "quake4.c"

$inventory = Get-Content -LiteralPath $PdbInventoryPath -Raw | ConvertFrom-Json

$implementationByRva = @{}
if (Test-Path -LiteralPath $ImplementationMapPath) {
    foreach ($implementation in (Import-Csv -LiteralPath $ImplementationMapPath)) {
        $implementationByRva[$implementation.rva.ToUpperInvariant()] = $implementation
    }
}

$pdbByRva = @{}
foreach ($function in $inventory.functions) {
    $rva = [uint64]$function.rva
    $key = '{0:X8}' -f $rva
    if (-not $pdbByRva.ContainsKey($key)) {
        $pdbByRva[$key] = [Collections.Generic.List[object]]::new()
    }
    $pdbByRva[$key].Add($function)
}

$hexByRva = @{}
$reader = [IO.File]::OpenText($hexRaysPath)
try {
    $pendingRva = $null
    while (($line = $reader.ReadLine()) -ne $null) {
        if ($line -match '^//----- \(([0-9A-Fa-f]{8})\)') {
            $virtualAddress = [Convert]::ToUInt64($matches[1], 16)
            $pendingRva = $virtualAddress - $imageBase
            continue
        }

        if ($null -ne $pendingRva -and -not [string]::IsNullOrWhiteSpace($line)) {
            $signature = $line.Trim()
            if ($signature.StartsWith('//')) {
                $signature = $signature.Substring(2).Trim()
            }
            $hexByRva[('{0:X8}' -f [uint64]$pendingRva)] = $signature
            $pendingRva = $null
        }
    }
}
finally {
    $reader.Dispose()
}

$allRvas = @($pdbByRva.Keys + $hexByRva.Keys | Sort-Object -Unique)
$rows = foreach ($key in $allRvas) {
    $rva = [Convert]::ToUInt64($key, 16)
    $pdbFunctions = @(
        if ($pdbByRva.ContainsKey($key)) {
            $pdbByRva[$key] | ForEach-Object { $_ }
        }
    )
    $hasPdb = $pdbFunctions.Count -gt 0
    $hasHex = $hexByRva.ContainsKey($key)
    $formattedRva = '0x{0:X8}' -f [uint64]$rva
    $implementation = $implementationByRva[$formattedRva]

    [PSCustomObject][ordered]@{
        rva = $formattedRva
        virtualAddress = '0x{0:X8}' -f ([uint64]$rva + $imageBase)
        pdbName = ($pdbFunctions | ForEach-Object { $_.name } | Sort-Object -Unique) -join ' | '
        undecoratedName = ($pdbFunctions | ForEach-Object { $_.undecoratedName } | Sort-Object -Unique) -join ' | '
        compiland = ($pdbFunctions | ForEach-Object { $_.compiland } | Where-Object { $_ } | Sort-Object -Unique) -join ' | '
        length = ($pdbFunctions | Measure-Object -Property length -Maximum).Maximum
        hexRaysSignature = if ($hasHex) { $hexByRva[$key] } else { '' }
        status = if ($hasPdb -and $hasHex) { 'address-matched' } elseif ($hasPdb) { 'pdb-only' } else { 'hex-only' }
        implementationPath = if ($null -ne $implementation) { $implementation.implementationPath } else { '' }
        verification = if ($null -ne $implementation) { $implementation.verification } else { 'unreviewed' }
        notes = if ($null -ne $implementation) { $implementation.notes } else { '' }
    }
}

$rows | Export-Csv -LiteralPath $LedgerPath -NoTypeInformation -Encoding UTF8

$summary = [ordered]@{
    schemaVersion = 2
    pdbFunctionRecords = $inventory.functions.Count
    pdbUniqueRvas = $pdbByRva.Count
    hexRaysFunctionRvas = $hexByRva.Count
    unionRvas = $rows.Count
    addressMatched = @($rows | Where-Object status -eq 'address-matched').Count
    pdbOnly = @($rows | Where-Object status -eq 'pdb-only').Count
    hexOnly = @($rows | Where-Object status -eq 'hex-only').Count
    implemented = @($rows | Where-Object implementationPath).Count
    compilesX86 = @($rows | Where-Object verification -like 'compiles-x86*').Count
    compilesX86DebugRelease = @($rows | Where-Object verification -eq 'compiles-x86-debug-release').Count
}

$json = $summary | ConvertTo-Json
[IO.File]::WriteAllText($SummaryPath, $json + [Environment]::NewLine, [Text.UTF8Encoding]::new($false))

$summary
