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

[string]$Script = $MyInvocation.MyCommand.Path
[string]$ScriptDir = Split-Path ${Script}
[string]$ConfigDir = "${ScriptDir}\conf"
[string]$OutputDir = "${ScriptDir}\output"
[string]$ScriptVersion = Get-Content ${ScriptDir}\VERSION
[string]$SourceFile = $Path
[string]$TempFile = New-TemporaryFile


if ($Version) {
    Write-Host "rdConfig/${ScriptVersion}"
    exit 0
}

$header = Get-Content $SourceFile -First 1
[array]$headerA = $header.split(' ')
$count = $headerA.count
Write-Host $count

Get-Content $SourceFile | Select-Object -Skip 1 | Set-Content "$TempFile"
Write-Host "$TempFile"

foreach($line in Get-Content $TempFile) {
    [array]$Value = $line.split(' ')
    $ConfigFile = "${OutputDir}\$($Value[0]).conf"
    Write-Host $ConfigFile
    Copy-Item "${ConfigDir}\default.conf" -Destination $confFile
    $i = 0
    while ($i -lt $count) {
        $replace = "^$($headerA[$i]).*"
        $replacement = "$($headerA[$i])=$($Value[$i])"
        ((Get-Content $ConfigFile) -replace "$replace","$replacement") | Set-Content $ConfigFile
        $i++
    }   
}

Remove-Item -Path $TempFile -Force
exit 0