
Write-Host -BackgroundColor Black
# Title
Write-Host "System Information:" -BackgroundColor Black -ForegroundColor DarkYellow
# New Line
Write-Host "`n"
#Info for the table
# Each word with a $ in front of it is just a "Variable" the runs a command
$User           = $env:USERNAME
$ComputerName   = $env:COMPUTERNAME
$Domain         = $env:USERDOMAIN
$Winrev         = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object -ExpandProperty ReleaseID
$IpConf         = Get-WmiObject win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress} | Select-Object -Expand IPAddress | Where-Object {$_ -notlike 'f*'}
$Model          = Get-WmiObject -Class Win32_Computersystem | Select-Object -ExpandProperty Model
$Manu           = Get-WmiObject -Class Win32_Computersystem | Select-Object -ExpandProperty Manufacturer
$Sn             = Get-WmiObject -Class Win32_SystemEnclosure | Select-Object -ExpandProperty SerialNumber
$ClientMemory   = Get-WmiObject CIM_PhysicalMemory | Measure-Object -Property capacity -Sum | ForEach-Object {[math]::round(($_.sum / 1GB),2)}
$CPUInfo        = Get-WmiObject -class win32_processor | Select-Object -ExpandProperty Name
$OSInfo         = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object -ExpandProperty ProductName
$DriveUsage     = Get-CimInstance win32_logicaldisk | Where-Object {$_.DeviceID -eq 'C:'} | foreach-object {Write-Output "$($_.caption) $([math]::round(($_.FreeSpace /1gb),2))GB / $([math]::round(($_.size /1gb),2))GB "}

# This is just writing out the contents of each of those variables
Write-Host "Computer: $ComputerName" -ForegroundColor Green
Write-Host "User: $User" -ForegroundColor Yellow
Write-Host "`n"
Write-Host "IP: "-ForegroundColor Red "$IpConf"
Write-Host "Domain:"-ForegroundColor Red " $Domain"
Write-Host "OS:"-ForegroundColor DarkGreen "$OSInfo | $WinRev"
Write-Host "CPU:" -ForegroundColor DarkGreen "$CPUInfo"
Write-Host "RAM:" -ForegroundColor DarkGreen "$ClientMemory"
Write-Host "Boot:"-ForegroundColor DarkGreen "$DriveUsage"
Write-Host "Serial:"-ForegroundColor DarkGreen "$Sn"
Write-Host "Model:"-ForegroundColor DarkGreen "$Model"
Write-Host "Manufacturer:" -ForegroundColor DarkGreen "$Manu"


Read-Host -prompt "Done?"
