## Apple USB and Mobile Device Ethernet drivers installer!
## Please report any issues at GitHub: https://github.com/NelloKudo/Apple-Mobile-Drivers-Installer

## Download links for Apple USB Drivers and Apple Mobile Ethernet USB Drivers respectively.
## All of these are downloaded from Microsoft's Update Catalog, which you can browse yourself at here: https://www.catalog.update.microsoft.com/

$AppleITunesLink = "https://www.apple.com/itunes/download/win64"
#	Apple, Inc. - USBDevice - 538.0.0.0
$AppleUsbDriverCabUrl = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drvs/2023/10/5fb262ea-d52d-46a7-9361-f3260ba57a1a_3e8075a4dded0a795131f82285e2f1a06525ebc2.cab"
#	Apple - Net - 7/15/2013 12:00:00 AM - 1.8.5.1
$AppleNetDriverCabUrl = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/11/netaapl_7503681835e08ce761c52858949731761e1fa5a1.cab"

Write-Host ""
Write-Host -ForegroundColor Cyan "Welcome to Apple USB and Mobile Device Ethernet drivers installer!!"
Write-Host ""

## Checking if the script is being run as admin..
if (-not ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544')) {
    Write-Host -ForegroundColor Yellow "Requesting administrative privileges..."
    $scriptPath = $MyInvocation.MyCommand.Path
    $argList = @()
    if ($scriptPath) {
        $argList += "-ExecutionPolicy Bypass"
        $argList += "-File `"$scriptPath`""
    } else {
        $argList += "-ExecutionPolicy Bypass"
        $argList += "-Command `"$($MyInvocation.Line)`""
    }
    Start-Process -FilePath "powershell.exe" -Verb RunAs -ArgumentList $argList
    exit 0
}

## Preparing the system to actually download drivers..
$destinationFolder = [System.IO.Path]::Combine($env:TEMP, "AppleDriTemp")
if (-not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

try {
    $currentPath = $PWD.Path
    Write-Host -ForegroundColor Yellow "Downloading Apple iTunes (205MB) and installing AppleMobileDeviceSupport64.msi.."
    Write-Host -ForegroundColor Yellow "(It might take a while! Script is not frozen!)"
    Invoke-WebRequest -Uri $AppleITunesLink -OutFile ([System.IO.Path]::Combine($destinationFolder, "iTunes64Setup.exe"))
    cd "$destinationFolder"
    Start-Process -FilePath "$destinationFolder\iTunes64Setup.exe" -ArgumentList "/extract" -Wait
    cd "$currentPath"
    Start-Process -FilePath "$destinationFolder\AppleMobileDeviceSupport64.msi" -ArgumentList "/qn" -Wait

    Write-Host -ForegroundColor Yellow "Downloading Apple USB and Mobile Device Ethernet drivers from Microsoft..."
    Invoke-WebRequest -Uri $AppleUsbDriverCabUrl -OutFile ([System.IO.Path]::Combine($destinationFolder, "AppleUSB-538.0.0.0-driv.cab"))
    Invoke-WebRequest -Uri $AppleNetDriverCabUrl -OutFile ([System.IO.Path]::Combine($destinationFolder, "AppleNet-1.8.5.1-driv.cab"))

    Write-Host -ForegroundColor Yellow "Extracting drivers..."
    & expand.exe -F:* "$destinationFolder\AppleUSB-538.0.0.0-driv.cab" "$destinationFolder" >$null 2>&1
    & expand.exe -F:* "$destinationFolder\AppleNet-1.8.5.1-driv.cab" "$destinationFolder" >$null 2>&1

    ## Installing drivers..
    Write-Host -ForegroundColor Yellow "Installing Apple USB and Mobile Device Ethernet drivers!"
    Write-Host -ForegroundColor Yellow "If any of your peripherals stop working for a few seconds that's due to Apple stuff installing."
    Write-Host ""
    Get-ChildItem -Path "$destinationFolder\*.inf" | ForEach-Object {
        pnputil /add-driver $_.FullName /install
        Write-Host ""
        Write-Host -ForegroundColor Yellow "Driver installed.."
        Write-Host ""
    }

    ## Cleaning..
    Remove-Item -Path $destinationFolder -Recurse -Force

} catch {
    Write-Host -ForegroundColor Red "Failed to complete installation. Error: $_"
}

Write-Host ""
Write-Host -ForegroundColor Cyan "Installation complete! Enjoy your Apple devices!!"
Write-Host -ForegroundColor Yellow "(If devices are still not working, a reboot might be needed!!)"
Write-Host ""
Read-Host ""
