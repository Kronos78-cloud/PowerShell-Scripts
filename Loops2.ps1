$services = "Spooler", "W32Time", "WinRM", "CoreMessaging", "Windows Update", "BITS"

foreach ($service in $services) {
    $result = Get-Service -Name $service
    Write-Host "Service is : $($result.Status)"
}
    