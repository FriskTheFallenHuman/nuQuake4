param(
    [string]$SourceRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")),
    [string]$DoomRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\DOOM-3-master\neo")),
    [string]$ReportPath = (Join-Path $PSScriptRoot "..\..\docs\reconstruction\doom-header-seed-report.csv")
)

$ErrorActionPreference = "Stop"

$sourceSets = @(
    @{ Doom = 'cm'; Destination = 'cm'; Recurse = $true },
    @{ Doom = 'framework'; Destination = 'framework'; Recurse = $true },
    @{ Doom = 'renderer'; Destination = 'renderer'; Recurse = $true },
    @{ Doom = 'sound'; Destination = 'sound'; Recurse = $true },
    @{ Doom = 'ui'; Destination = 'ui'; Recurse = $true },
    @{ Doom = 'sys'; Destination = 'sys'; Recurse = $false },
    @{ Doom = 'sys\win32'; Destination = 'sys\win32'; Recurse = $true },
    @{ Doom = 'tools\compilers\aas'; Destination = 'aas'; Recurse = $true }
)

$rows = foreach ($set in $sourceSets) {
    $doomDirectory = Join-Path $DoomRoot $set.Doom
    $parameters = @{
        LiteralPath = $doomDirectory
        File = $true
        Filter = '*.h'
    }
    if ($set.Recurse) {
        $parameters.Recurse = $true
    }

    foreach ($source in (Get-ChildItem @parameters)) {
        $relative = $source.FullName.Substring($doomDirectory.Length).TrimStart('\', '/')
        $destinationRelative = Join-Path $set.Destination $relative
        $destination = Join-Path $SourceRoot $destinationRelative
        $status = 'destination-exists'

        if (-not (Test-Path -LiteralPath $destination)) {
            New-Item -ItemType Directory -Path (Split-Path -Parent $destination) -Force | Out-Null
            Copy-Item -LiteralPath $source.FullName -Destination $destination
            $status = 'copied'
        }

        [PSCustomObject][ordered]@{
            source = $source.FullName.Substring($DoomRoot.Length).TrimStart('\', '/')
            destination = $destinationRelative
            status = $status
        }
    }
}

$rows | Export-Csv -LiteralPath $ReportPath -NoTypeInformation -Encoding UTF8
$rows | Group-Object status | Sort-Object Count -Descending | Select-Object Count, Name

