$LogPath = Join-Path $PSScriptRoot "activity.log"
Add-Content -Path $LogPath -Value "[$(Get-Date -Format 'dd-MM-yyyy HH:mm:ss')] SYSTEM MONITOR STARTED"
$HomeScreen = $true
$lastlong = Get-Date
$previousNetwork = Get-NetAdapterStatistics -name "Wi-Fi"
$previousnetworktime = Get-Date
while($Homescreen)
{
  try 
  {
    $cpu = Get-ciminstance Win32_Processor -ErrorAction Stop
  }
  catch 
  {
    Write-Host "ERROR: COULDNT RETRIEVE CPU INFO !!" -FOREGROUNDCOLOR RED
    Start-Sleep -Seconds 2
    continue
  }
 try 
 {
  $disk = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction Stop
 }
 catch 
 {
  Write-host "ERROR: COULDNT RETRIEVE DISK INFO !!" -ForegroundColor Red
  Start-Sleep -Seconds 2
  continue
 }
$network = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
$currentNetwork = Get-NetAdapterStatistics -Name "Wi-Fi"
$currentNetworkTime = Get-Date
$timeelapsed = ($currentNetworkTime - $previousNetworktime).TotalSeconds
if($timeelapsed -gt 0)
{
$downloadspeed = ($currentNetwork.ReceivedBytes - $previousnetwork.receivedbytes)/1mb/$timeelapsed
$uploadspeed = ($currentNetwork.SentBytes - $previousnetwork.SentBytes)/1mb/$timeelapsed
}
else 
{
$downloadspeed = 0
$uploadspeed = 0  
}
$previousnetwork = $currentNetwork
$previousnetworktime = $currentNetworkTime
$diskinfo = foreach($drive in $disk)
{
$total = $Drive.Size / 1GB
$free = $Drive.FreeSpace / 1GB
$used =  $total - $free
$usage = ($used - $total)*100
[PSCustomObject]@{
  Drive = $drive.DeviceID
  TotalGB = [math]::round($total,2)
  FreeGB = [math]::round($free,2)
  UsedGB = [math]::round($used,2)
  UsedPercentage = [math]::round($usage,2)
}
}

$windows = Get-CimInstance Win32_OperatingSystem
$uptime = (Get-Date) - $windows.LastBootUpTime
$ram = Get-CimInstance Win32_OperatingSystem
$TotalRam = $ram.TotalVisibleMemorySize
[double]$TRG = $TotalRam / 1MB
$FreeRam = $ram.FreePhysicalMemory
[double]$FRG = $FreeRam / 1MB
[double]$Usedram = $TRG  - $FRG
$name = $env:COMPUTERNAME
[int]$RU = ($Usedram/$TRG)*100
$process = Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5

if(((Get-Date) - $lastlong).TotalSeconds -ge 60)
{
Add-Content -Path $LogPath -Value "[$(Get-Date -Format 'dd-MM-yyyy HH:mm:ss')] CPU: $($CPU.LoadPercentage)% | RAM: $ru%"
$lastlong = Get-Date
}
Clear-Host
Write-Host ""
Write-Host "======================"
Write-Host "    SYSTEM MONITOR  "
Write-Host "======================"
Write-Host "RAM USAGE: $([math]::round($ru,2)) %"
write-host "CPU USAGE: $($cpu.LoadPercentage) %"
Write-Host "DISK USAGE: $([math]::round($diskusage,2)) %"
Write-Host "DOWLOAD SPEED: $([math]::Round($downloadspeed,2))MB/s"
Write-Host "UPLOAD SPEED: $([math]::Round($uploadspeed,2))MB/s"
Write-Host ""
if($ru -ge 85 -or $cpu.LoadPercentage -ge 90)
{
  Write-host "WARNING !!!" -ForegroundColor red
}
if($ru -ge 85)
{
  Write-host "HIGH RAM USAGE" -ForegroundColor red
}
if($cpu.LoadPercentage -ge 90)
{
  Write-Host "HIGH CPU USAGE" -ForegroundColor red
}
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
      Write-Host ""
      Write-Host "1.[RAM]"
      Write-Host "2.[CPU]"
      Write-Host "3.[DISK]"
      Write-Host "4.[NETWORK]"
      Write-Host "5.[PROCESSES]"
      $ic = [console]::ReadKey($true).KeyChar
      if($ic -eq "1")
      {
        Clear-Host 
        Write-Host "===================" 
        Write-Host "    RAM MONITOR    "
        Write-Host "==================="
        Write-Host ""
        Write-Host "TOTALE USABLE: $([math]::Round($TRG,2)) GB"
        Write-Host "FREE RN: $([MATH]::ROUND($FRG,2)) GB"
        Write-Host "IN USE: $([MATH]::ROUND($Usedram,2)) GB"
        Write-Host "RAM USAGE: $([math]::Round($Ru,2)) % "
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
        Write-Host ""
        Write-host "CPU: $($cpu.Name)"
        Write-Host "CORES: $($cpu.NumberOfCores)"
        Write-Host "LOGICAL PROCESSERS: $($cpu.NumberOfLogicalProcessors)"
        Write-host "USAGE: $($cpu.LoadPercentage) %"
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
        Write-Host ""
        $diskInfo | Format-Table -AutoSize
        Write-Host "TOTAL STORAGE: $dtg GB"
        Write-Host "FREE STORAGE: $dfg GB"
        Write-Host ""
        Write-Host "Press Any Key To Return"
        [console]::ReadKey($true)|Out-Null
      }
      elseif ($ic -eq "4") 
      {
        Clear-Host
        foreach($adapter in $network)
        {
          $stats = Get-NetAdapterStatistics -name $adapter.Name
          
        
        Write-Host "======================"
        Write-host "   NETWORK MONITER"
        Write-Host "======================"
        Write-Host ""
        Write-hoST "ADAPTER: $($adapter.Name)"
        Write-Host "STATUS: $($adapter.Status)"
        Write-Host "LINKSPEED: $($adapter.LinkSpeed)"
        Write-Host "DOWNLOADED: $([math]::Round($stats.ReceivedBytes / 1MB,2 )) MB"
        Write-Host "UPLOADED : $([math]::Round($stats.sentbytes / 1MB,2)) MB"
        Write-host ""
        }
        write-host "Press Any Key To Return"
        [console]::ReadKey($true)|Out-Null
      }
      elseif($ic -eq "5")
      {
        Clear-Host
        Write-Host "================="
        Write-Host "    PROCESSES "
        Write-Host "================="
        $process | Select-Object ProcessName, 
        @{
        NAME = "RAM (MB)"
        EXPRESSION = {[MATH]::Round($_.WorkingSet64 / 1MB,2)}
        }| Format-Table -AutoSize
        
        Write-host ""
        Write-Host "Press Any Key To Return"
        [console]::ReadKey($true)|out-null
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






