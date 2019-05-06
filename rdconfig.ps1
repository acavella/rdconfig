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
    [string] $p1
)

[string] $scriptPath = $MyInvocation.MyCommand.Path
[string] $__rootDir = Split-Path $scriptPath
[string] $__confDir = $__rootDir +"\conf"
[string] $__outDir = $__rootDir +"\output"
[string] $fileDTG = $(get-date -f yyyy-MM-dd)
[string] $sourceFile = $p1
$TempFile = New-TemporaryFile

# Read headers from source file
$header = Get-Content $sourceFile -First 1
Write-Host $header
[array] $headerA = $header.split(' ')
$count = $headerA.count
Write-Host $count

# Create temporary source file
Get-Content $sourceFile | Select-Object -Skip 1 | Set-Content "$TempFile"
Write-Host "$TempFile"

# Update 
foreach($line in Get-Content $TempFile) {
    Write-Host $line
    [array] $customA = $line.split(' ')
    Copy-Item "${__confDir}\default.conf" -Destination "${__outDir}\${customA[0]}.conf"
    
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
}

# Clean up temporary files
Remove-Item -Path $TempFile -Force

exit 0


$key = "replParm1=${variable}"
((Get-Content -path $args -Raw) -replace 'replParm1=true',$key) | Set-Content -Path $args