<#
    .SYNOPSIS
        Writes customized output to a host.
    .DESCRIPTION
        The Write-Host cmdlet customizes output. You can specify the color of text by using
        the ForegroundColor parameter, and you can specify the background color by using the
        BackgroundColor parameter. The Separator parameter lets you specify a string to use to
        separate displayed objects. The particular result depends on the program that is
        hosting Windows PowerShell.
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

# Update 
foreach($line in Get-Content $sourceFile) {
    Write-Host $line
    $ssid,$devpin,$guipass,$pskpass = $line.split(' ')
    Copy-Item "${__confDir}\default.conf" -Destination "${__outDir}\$ssid.conf"
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

exit 0


$key = "replParm1=${variable}"
((Get-Content -path $args -Raw) -replace 'replParm1=true',$key) | Set-Content -Path $args