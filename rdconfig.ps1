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
[string]$sourceFile = $Path
[string]$tempFile = New-TemporaryFile

Write-Host $scriptPath

exit 0

if ($version) {
    Write-Host "rdConfig/${ScriptVersion}"
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
    $confFile = "${OutputDir}\$($flag[0]).conf"
    Write-Host $confFile
    Copy-Item "${ConfigDir}\default.conf" -Destination $confFile
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