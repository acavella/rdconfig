<#
    .SYNOPSIS
        Writes customized variables to Netgear RD config.
    .DESCRIPTION
        rdConfig automates the process of configuring Netgear Retransmission Devices. Custom 
        variables are input via a space delimited file, each new line represents a new device. 
        Custom configuration files are output as <ssid>.conf and can be automatically loaded 
        on the RD via CURL POST.
#>

param (
    [Parameter(Position=0)]
    [Alias("Ver")]
    [switch]$Version = $false,

    [Parameter(Position=0)]
    [Alias("FilePath")]
    [string[]]$Path,

    [Parameter(Position=0)]
    [Alias("V")]
    [switch]$Verb = $false
)

[string]$scriptPath = $MyInvocation.MyCommand.Path
[string]$__rootDir = Split-Path $scriptPath
[string]$__confDir = $__rootDir +"\conf"
[string]$__outDir = $__rootDir +"\output"
[string]$sourceFile = $Path
[string]$scriptVer = Get-Content ${__rootDir}\VERSION
$tempFile = New-TemporaryFile

if ($version) {
    Write-Host "rdConfig/${scriptVer}"
    exit 0
}

$header = Get-Content $sourceFile -First 1
[array]$headerA = $header.split(' ')
$count = $headerA.count
Write-Host $count

Get-Content $sourceFile | Select-Object -Skip 1 | Set-Content "$tempFile"
Write-Host "$tempFile"

foreach($line in Get-Content $tempFile) {
    [array]$flag = $line.split(' ')
    $confFile = "${__outDir}\$($flag[0]).conf"
    Write-Host $confFile
    Copy-Item "${__confDir}\default.conf" -Destination $confFile
    $i = 0
    while ($i -lt $count) {
        $replace = "^$($headerA[$i]).*"
        $replacement = "$($headerA[$i])=$($flag[$i])"
        ((Get-Content $confFile) -replace "$replace","$replacement") | Set-Content $confFile
        $i++
    }   
}

Remove-Item -Path $TempFile -Force
exit 0