
$title = "Overlord"
write-output "Welcome to planet $env:computername, "$title $env:username"
$time = (get-date -format "HH:MM tt on dddd")
write-output "It is $time ""