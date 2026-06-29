# =================================================================================
# Script Name: Get-systeminfo.ps1
# Description: xxxxxxxxxxxxxxx
# Author: Nick Iatridis
# Date: 08/06/2026
# =================================================================================

# --Variables--
$computerName = "POWERSHELL"
$currentUser = "Administrator"
$today = Get-Date -Format "dd/MM/yyyy HH:mm"
$os = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, LastBootUpTime, TotalVisibleMemorySize
$drives = Get-PSDrive | Where-Object {$_.Provider -like "*FileSystem*"} | Select-Object Name, Used, Free
$stoppedServices = Get-Service | Where-Object {$_.Status -eq "Stopped"} | Select-Object Name, Status

# --Display the Information--
Write-Host "Server Name : $computerName"
Write-Host "Reported by : $currentUser"
Write-Host "Report Time : $today"

Write-Host "Operating System : $($os.Caption)"
Write-Host "Last Rebooted : $($os.LastBootUpTime)"
Write-Host "Total Memory : $($os.TotalVisibleMemorySize) KB"

$drives | Format-Table -AutoSize

$stoppedServices | Format-Table -AutoSize
