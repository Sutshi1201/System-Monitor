$InstallDir = "$env:USERPROFILE\SystemMonitor"
$BaseURL = "https://raw.githubusercontent.com/Sutshi1201/System-Monitor/main"
New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
Invoke-WebRequest "$BaseURL/SystemMonitor.ps1" `
    -OutFile "$InstallDir/SystemMonitor.ps1"
if (!(Test-Path "$InstallDir\activity.log")) {
    Invoke-WebRequest "$BaseURL/activity.log" `
        -OutFile "$InstallDir/activity.log"
}
Write-Host ""
Write-Host "SYSTEM MONITOR INSTALLED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "Installation: $InstallDir"