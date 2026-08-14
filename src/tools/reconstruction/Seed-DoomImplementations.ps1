param(
    [string]$SourceRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")),
    [string]$DoomRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\DOOM-3-master\neo")),
    [string]$PdbInventoryPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\pdb-inventory.json"),
    [string]$ReportPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\doom-seed-report.csv")
)

$ErrorActionPreference = "Stop"
$enginePrefix = '\Ritual\Q4x\Win32\Release\quake4\'
$originalSourcePrefix = 'c:\ritual\q4x\code\'

function Normalize-RelativePath([string]$path) {
    return $path.Replace('/', '\').TrimStart('\').ToLowerInvariant()
}

$inventory = Get-Content -LiteralPath $PdbInventoryPath -Raw | ConvertFrom-Json

$targetSourcesByBase = @{}
foreach ($sourceFile in $inventory.sourceFiles) {
    $normalized = $sourceFile.Replace('/', '\').ToLowerInvariant()
    if (-not $normalized.StartsWith($originalSourcePrefix)) {
        continue
    }

    $relative = $normalized.Substring($originalSourcePrefix.Length)
    $extension = [IO.Path]::GetExtension($relative)
    if ($extension -notin '.cpp', '.c', '.cc') {
        continue
    }

    $base = [IO.Path]::GetFileNameWithoutExtension($relative)
    if (-not $targetSourcesByBase.ContainsKey($base)) {
        $targetSourcesByBase[$base] = [Collections.Generic.List[string]]::new()
    }
    $targetSourcesByBase[$base].Add($relative)
}

$doomByBase = @{}
foreach ($path in (rg --files $DoomRoot)) {
    $extension = [IO.Path]::GetExtension($path).ToLowerInvariant()
    if ($extension -notin '.cpp', '.c', '.cc') {
        continue
    }

    $base = [IO.Path]::GetFileNameWithoutExtension($path).ToLowerInvariant()
    if (-not $doomByBase.ContainsKey($base)) {
        $doomByBase[$base] = [Collections.Generic.List[string]]::new()
    }
    $doomByBase[$base].Add($path)
}

$compilands = @(
    $inventory.compilands |
        ForEach-Object { $_.name } |
        Where-Object { $_.StartsWith($enginePrefix, [StringComparison]::OrdinalIgnoreCase) -and $_.EndsWith('.obj', [StringComparison]::OrdinalIgnoreCase) }
)

$rows = foreach ($compiland in $compilands) {
    $moduleBase = [IO.Path]::GetFileNameWithoutExtension($compiland).ToLowerInvariant()
    $targetCandidates = @(
        if ($targetSourcesByBase.ContainsKey($moduleBase)) {
            $targetSourcesByBase[$moduleBase] | ForEach-Object { $_ }
        }
    )
    $doomCandidates = @(
        if ($doomByBase.ContainsKey($moduleBase)) {
            $doomByBase[$moduleBase] | ForEach-Object { $_ }
        }
    )

    $selectedSource = $null
    $selectedRelative = $null

    foreach ($targetRelative in $targetCandidates) {
        $exact = Join-Path $DoomRoot $targetRelative
        if (Test-Path -LiteralPath $exact) {
            $selectedSource = $exact
            $selectedRelative = $targetRelative
            break
        }
    }

    if ($null -eq $selectedSource -and $doomCandidates.Count -eq 1) {
        $selectedSource = $doomCandidates[0]
        if ($targetCandidates.Count -eq 1) {
            $selectedRelative = $targetCandidates[0]
        } else {
            $selectedRelative = Normalize-RelativePath($selectedSource.Substring($DoomRoot.Length))
        }
    }

    $status = 'no-doom-candidate'
    $destination = ''
    if ($null -ne $selectedSource) {
        $destination = Join-Path $SourceRoot $selectedRelative
        if (Test-Path -LiteralPath $destination) {
            $status = 'destination-exists'
        } else {
            $destinationDirectory = Split-Path -Parent $destination
            New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
            Copy-Item -LiteralPath $selectedSource -Destination $destination
            $status = 'copied'
        }
    } elseif ($doomCandidates.Count -gt 1) {
        $status = 'ambiguous-doom-candidate'
    }

    [PSCustomObject][ordered]@{
        compiland = $compiland
        module = $moduleBase
        targetSourceCandidates = $targetCandidates -join ' | '
        doomCandidates = ($doomCandidates | ForEach-Object { $_.Substring($DoomRoot.Length).TrimStart('\', '/') }) -join ' | '
        selectedSource = if ($selectedSource) { $selectedSource.Substring($DoomRoot.Length).TrimStart('\', '/') } else { '' }
        destination = if ($destination) { $destination.Substring($SourceRoot.Length).TrimStart('\', '/') } else { '' }
        status = $status
    }
}

$rows | Export-Csv -LiteralPath $ReportPath -NoTypeInformation -Encoding UTF8
$rows | Group-Object status | Sort-Object Count -Descending | Select-Object Count, Name

