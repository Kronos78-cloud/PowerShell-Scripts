# =================================================================================
# Script Name: Get-systeminfo.ps1
# Description: xxxxxxxxxxxxxxx
# Author: Nick Iatridis
# Date: 08/06/2026
# =================================================================================

# --Variables--
$computerName = $env:COMPUTERNAME
$currentUser = $env:USERNAME
$today = Get-Date -Format "dd/MM/yyyy HH:mm"
$os = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, LastBootUpTime, TotalVisibleMemorySize
$drives = Get-PSDrive | Where-Object {$_.Provider -like "*FileSystem*"} | Select-Object Name, Used, Free
$stoppedServices = Get-Service | Where-Object {$_.Status -eq "Stopped"} | Select-Object Name, Status

$totalMemoryGB = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)

# --Display the Information--
Write-Host "Server Name : $computerName"
Write-Host "Reported by : $currentUser"
Write-Host "Report Time : $today"

Write-Host "Operating System : $($os.Caption)"
Write-Host "Last Rebooted : $($os.LastBootUpTime)"
Write-Host "Total Memory : $totalMemoryGB GB" -ForegroundColor Green

$drives | Format-Table -AutoSize

$stoppedServices | Format-Table -AutoSize

foreach ($drive in $drives) {
    $freeGB = [math]::Round($drive.Free / 1GB, 2)
    if ($freeGB -lt 10) {
        Write-Host "Drive $($drive.Name) Free Space: $freeGB GB ***LOW DISK SPACE***"
    }
    else {
        Write-Host "Drive $($drive.Name) Free Space: $freeGB GB"
    }
}


Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Report Generated : $today" -ForegroundColor DarkGreen
Write-Host "Run on           : $computerName" -ForegroundColor DarkGreen
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Script completed successfully." -ForegroundColor Green