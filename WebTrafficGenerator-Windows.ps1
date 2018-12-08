<#
.SYNOPSIS
  PowerShell based web traffic generator
.DESCRIPTION
  This is intended to be set up as a scheduled task or service on a host to generate random appearing web traffic
  to prevent firewall administrators from picking out red team traffic easily during a red team engagement for 
  CCDC training
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0
  Author:         5yn@x
  Creation Date:  Decmber 7th, 2018
  Purpose/Change: Initial script development

  MAKE SURE TO CHANGE THE PS1 NAME PRIOR TO DELIVERING IT TO THE TARGET MACHINE
  
.EXAMPLE
--Example set up for scheduled task--
$time = (get-date).AddMinutes(5).ToString("HH:mm")
$action = New-ScheduledTaskAction -Execute 'Powershell.exe'-Argument '-ExecutionPolicy Bypass -WindowStyle Hidden C:\Tools\WTG\WTG.ps1'
$trigger =  New-ScheduledTaskTrigger -Daily -At $time
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "IE Update" -Description "Internet Explorer Update"

--Example set up for service--
New-Service -Name IE_Update -BinaryPathName C:\Tools\WTG\WTG.ps1 -DisplayName IE_Update -Description "Internet Explorer Update" -StartupType Automatic
Start-Service -Name IE_Update
#>

function webtraffic {
    
    $Sleep_Interval=2

    while ($true) {

        $links = (Invoke-WebRequest -Uri 'https://www.alexa.com/topsites' -UseBasicParsing -UserAgent "Red-Team").Links | Select-Object -ExpandProperty href
            foreach ($link in $links) {
            
                if ($link -match 'siteinfo'){
                
                    $uri = $link.split("/")[2]
                    Invoke-WebRequest -uri $uri -UseBasicParsing -UserAgent "Red-Team" -ErrorAction SilentlyContinue
                    Start-Sleep -Seconds $Sleep_Interval
                    $Sleep_Interval = Get-Random -Minimum 0 -Maximum 4
                }   
            
                else {

                    continue
                }
    
           
        }
 
    }

}

webtraffic