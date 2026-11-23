$HomeScreen = $true
while($Homescreen)
{
$cpu = Get-ciminstance Win32_Processor
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID= 'C:'"
$network = Get-NetAdapter
[double]$dtg = $disk.Size / 1GB
[double]$dfg = $disk.FreeSpace / 1GB
$windows = Get-CimInstance Win32_OperatingSystem
$ram = Get-CimInstance Win32_OperatingSystem
$TotalRam = $ram.TotalVisibleMemorySize
[double]$TRG = $TotalRam / 1MB
$FreeRam = $ram.FreePhysicalMemory
[double]$FRG = $FreeRam / 1MB
[double]$Usedram = $TRG  - $FRG
$name = $env:COMPUTERNAME
[int]$RU = ($Usedram/$TRG)*100
$diskusage = (($dtg - $dfg)/$dtg)*100
Clear-Host
Write-Host ""
Write-Host "=========================="
Write-Host "  HOMELAB SYSTEM MONITOR  "
Write-Host "=========================="
Write-Host "RAM USAGE: $([math]::round($ru,2)) %"
write-host "CPU USAGE: $($cpu.LoadPercentage) %"
Write-Host "DISK USAGE: $([math]::round($diskusage,2)) %"
Write-Host ""
Write-host "1.[MORE INFO]"
Write-Host "2.[EXIT]"
if([console]::KeyAvailable)
{
  $choice = [console]::ReadKey($true).KeyChar
switch($choice)
{
    "1"
    {
      Clear-Host
      Write-Host "SYSTEM INFORMATION"
      Write-Host "NAME: $name"
      Write-Host "WINDOWS VERSION: $($windows.Caption)"
      Write-Host "1.[RAM]"
      Write-Host "2.[CPU]"
      Write-Host "3.[DISK]"
      Write-Host "4.[NETWORK]"
      $ic = [console]::ReadKey($true).KeyChar
      if($ic -eq "1")
      {
        Clear-Host 
        Write-Host "===================" 
        Write-Host "    RAM MONITOR    "
        Write-Host "==================="
        Write-Host "Totale Usable: $([math]::Round($TRG,2)) GB"
        Write-Host "Free Rn: $([MATH]::ROUND($FRG,2)) GB"
        Write-Host "In Use: $([MATH]::ROUND($Usedram,2)) GB"
        Write-Host "Ram Usage: $([math]::Round($Ru,2)) % "
        write-host ""
        Write-host "Press Any Key To Return"
        [console]::ReadKey($true)|Out-Null
      }
      elseif($ic -eq "2")
      {
        Clear-Host
        Write-Host "==================="
        Write-Host "    CPU MONITOR "
        Write-Host "==================="
        Write-host "CPU: $($cpu.Name)"
        Write-Host "Cores: $($cpu.NumberOfCores)"
        Write-Host "Logical Processers: $($cpu.NumberOfLogicalProcessors)"
        Write-host "Usage: $($cpu.LoadPercentage) %"
        Write-Host ""
        Write-Host "Press Any Key To Return"
        [console]::ReadKey($true)|out-null
      }
      elseif($ic -eq "3")
      {
        Clear-Host
        Write-Host "===================="
        Write-Host "    DISK MONITOR    "
        Write-Host "===================="
        Write-Host "Total Space: $dtg GB"
        Write-Host "Free Space: $dfg GB"
        Write-Host ""
        Write-Host "Press Any Key To Return"
        [console]::ReadKey($true)|Out-Null
      }
      elseif ($ic -eq "4") 
      {
        Write-Host ""
        Write-Host "======================"
        Write-host "   NETWORK MONITER"
        Write-Host "======================"
        Write-hoST "$($network.Name)"
        Write-Host "$($network.Status)"
        Write-Host "$($network.LinkSpeed)"
      }
    }
    "2"
    {
        Clear-Host
        write-host ""
      Write-Host "========="
      Write-Host "   BYE"
      Write-Host "========="
      $HomeScreen = $false
    }
    default
    {

    }
}
}

}






