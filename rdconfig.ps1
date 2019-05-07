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
    [switch]$version = $false,
    [string]$p1
)

[string]$scriptPath = $MyInvocation.MyCommand.Path
[string]$__rootDir = Split-Path $scriptPath
[string]$__confDir = $__rootDir +"\conf"
[string]$__outDir = $__rootDir +"\output"
[string]$sourceFile = $p1
[string]$scriptVer = Get-Content ${__rootDir}\VERSION
$tempFile = New-TemporaryFile

# Script basic functions
if ($version) {
    Write-Host "rdConfig/${scriptVer}"
    exit 0
}

# Read headers from source file
$header = Get-Content $sourceFile -First 1
[array]$headerA = $header.split(' ')
$count = $headerA.count
Write-Host $count

# Create temporary source file
Get-Content $sourceFile | Select-Object -Skip 1 | Set-Content "$tempFile"
Write-Host "$tempFile"

# Read variables out of temporary file and assign to array
foreach($line in Get-Content $tempFile) {
    [array]$flag = $line.split(' ')
    Write-Host $flag[0]
    Copy-Item "${__confDir}\default.conf" -Destination "${__outDir}\$($flag[0]).conf"

    #for ($i=1;$i -lt $count; $i++) {
    #    ((Get-Content ${__outDir}\${flag[0]}.conf) -replace '^$headerA[$i].$','$headerA[$i]=$flag[$i]') | Set-Content ${__outDir}\${flag[0]}.conf
    #}
   
}

# Clean up temporary files
#Remove-Item -Path $TempFile -Force
exit 0


$key = "replParm1=${variable}"
((Get-Content -path $args -Raw) -replace 'replParm1=true',$key) | Set-Content -Path $args

Write-Host $ssid
Write-Host $devpin
$devpinENC = [System.Web.HttpUtility]::UrlEncode($devpin)
Write-Host $devpinENC
Write-Host $guipass
$guipassENC = [System.Web.HttpUtility]::UrlEncode($guipass)
Write-Host $guipassENC
Write-Host $pskpass
$pskpassENC = [System.Web.HttpUtility]::UrlEncode($pskpass)
Write-Host $pskpassENC