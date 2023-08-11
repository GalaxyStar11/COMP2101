function welcome {
$title = "Overlord"
write-output "Welcome to planet $env:computername, '$title $env:username'"
$time = (get-date -format "HH:MM tt on dddd")
write-output "It is $time "
}

welcome

function get-cpuinfo {
    Get-CimInstance cim_processor | Select-Object Manufacturer, Name, MaxClockSpeed, CurrentClockSpeed, NumberOfCores
 }
get-cpuinfo        

function get-mydisks {
    Get-CimInstance cim_diskdrive | Select-Object Manufacturer, Model, SerialNumber, Size, FirmwareRevision | Format-Table
}

get-mydisks