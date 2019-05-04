param (
    [string] $p1
)

[string] $scriptPath = $MyInvocation.MyCommand.Path
[string] $__rootDir = Split-Path $scriptPath
[string] $__confDir = $__rootDir +"\conf"
[string] $__outDir = $__rootDir +"\output"
[string] $fileDTG = $(get-date -f yyyy-MM-dd)
[string] $sourceFile = $p1

# Script functions
function encode {
    $script:textout = [System.Web.HttpUtility]::UrlEncode($textin)
}

function testoutput {
    Write-Output $scriptPath
    Write-Output $__rootDir
    Write-Output $__confDir
    Write-Output $__outDir
    Write-Output $fileDTG
    Write-Output $p1
}

# Script Logic
foreach($line in Get-Content $sourceFile) {
    Write-Host $line
    $ssid,$devpin,$guipass,$pskpass = $line.split(' ')
    Copy-Item "$__confDir\default.conf" -Destination "$__outDir\$ssid.conf"
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


$textin = Read-Host "Web Password"
encode
$key = "replParm1="+$textout
((Get-Content -path $args -Raw) -replace 'replParm1=true',$key) | Set-Content -Path $args