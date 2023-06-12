#!/bin/bash
#echo commands are used to display labels

#Testing if the script is run with root privilage and if not, exit
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for this script";
	exit 1
fi

################ System Description ######################

#lshw command used with class "system" to filter system hardware
#grep is used to get 'description' field, while awk is used to print the 2nd itme field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
compDescription=$(lshw -class system | grep 'adescription:' | awk '{print $2}')
if [ -z "$compDescription" ]; then 
	compDescription='"Error!!!" Data is unavailable'
else compDescription=$(lshw -class system | grep 'description:' | awk '{print $2}')
fi

#lshw command used with class "system" to filter system hardware
#grep is used to get 'vendor' field, while awk is used to print all the fields after field 1
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
compManufacture=$(lshw -class system | grep 'avendor:' | head -1 | awk '{$1=""; print $0}')
if [ -z "$compManufacture" ]; then
	compManufacture='"Error!!!" Data is unavailable'
else compManufacture=$(lshw -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}')
fi

#lshw command used with class "system" to filter system hardware
#grep is used to get 'serial:' field, while awk is used to print all the fields after field 1
#-z test command is used to check if the data is available or not' by testing the variable and checking if it's empty or not. If empty an error is displayed
compSerial=$(lshw -class system | grep 'aserial:' | awk '{$1=""; print $0}')
if [ -z "$compSerial" ]; then
	compSerial='"Error!!!" Data is unavailable'
else compSerial=$(lshw -class system | grep 'serial:' | awk '{$1=""; print $0}')
fi

################# CPU Information ######################

#lscpu command is used which gives CPU information
#grep is used to get 'Model name:' field, while 
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpumodel=$(lscpu | grep 'Model name:' | sed 's/,*Model name: *//')
if [ -z "$cpumodel" ]; then
	cpumodel='"Error!!! Data is unavailable'
else cpumodel=$(lscpu | grep 'Model name:' | sed 's/,*Model name: *//')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'Architecture:' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuArch=$(lscpu | grep 'Architecture:' | awk '{print $2}')
if [ -z "$cpuArch" ]; then
	cpuArch='"Error!!! Data is unavailable'
else cpuArch=$(lscpu | grep 'Architecture:' | awk '{print $2}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'CPU(s):' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCore=$(lscpu | grep 'CPU(s):' | head -1 | awk '{print $2}')
if [ -z "$cpuCore" ]; then
	cpuCore='"Error!!! Data is unavailable'
else cpuCore=$(lscpu | grep 'CPU(s):' | head -1 | awk '{print $2}')
fi

#lshw command used with class "cpu" to filter cpu hardware
#grep is used to get 'capacity::' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuMaxSpeed=$(lshw -class cpu | grep 'capacity:' | head -1 | awk '{print $2}')
if [ -z "$cpuMaxSpeed" ]; then
	cpuMaxSpeed='"Error!!! Data is unavailable'
else cpuMaxSpeed=$(lshw -class cpu | grep 'capacity:' | head -1 | awk '{print $2}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L1d' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL1D=$(lscpu | grep 'L1d' | awk '{print $3}')
if [ -z "$cpuCacheL1D" ]; then
	cpuCacheL1D='"Error!!! Data is unavailable'
else cpuCacheL1D=$(lscpu | grep 'L1d' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L1i' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL1I=$(lscpu | grep 'L1i' | awk '{print $3}')
if [ -z "$cpuCacheL1I" ]; then
	cpuCacheL1I='"Error!!! Data is unavailable'
else cpuCacheL1I=$(lscpu | grep 'L1i' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L2' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL2=$(lscpu | grep 'L2' | awk '{print $3}')
if [ -z "$cpuCacheL2" ]; then
	cpuCacheL2='"Error!!! Data is unavailable'
else cpuCacheL2=$(lscpu | grep 'L2' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L3' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL3=$(lscpu | grep 'L3' | awk '{print $3}')
if [ -z "$cpuCacheL3" ]; then
	cpuCacheL3='"Error!!! Data is unavailable'
else cpuCacheL3=$(lscpu | grep 'L3' | awk '{print $3}')
fi

##################### OS Information #####################

#hostnamectl command to display OS info with awk command to only get the required data in all the fields after field 1 exclusive
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
distroVer=$(hostnamectl | grep 'Kernel:' | awk '{$1=""; print $0}') 
if [ -z "$distroVer" ]; then
	distroVer='"Error!!!" Data is unavailable'
else distroVer=$(hostnamectl | grep 'Kernel:' | awk '{$1=""; print $0}') 
fi

#hostnamectl command to display OS info with awk command to only get the required data
#FNR == 7 is used for selecting the line 7 and print $3, $4, $5 is used to print the 3rd, 4th, and 5th item field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
os=$(hostnamectl | awk 'FNR == 7 {print $3, $4, $5}')
if [ -z "$os" ]; then
	os='"Error!!!" Data is unavailable'
else os=$(hostnamectl | awk 'FNR == 7 {print $3, $4, $5}')
fi

#################### Old Variables ################################
#hostname command with uppercase "-I" option to display IP address
#ip=$(hostname -I)

#Hostname command with "-f" option to display the fqdn information only
#fqdn=$(hostname -f)

# df command with '/' for root directory and "-h" option for human readable format with awk command to get only the required data
#FNR == 2 is used for choosing the line 2 and print $4 prints the 4th item field
#freespace=$(df / -h | awk 'FNR == 2 {print $4}')

# if all data items in a section are unavailable, then an error is printed
if [[  "$compManufacture" == "$compDescription" ]] && [[ "$compDescription"  == "$compSerial" ]]; then
	sysDesc='     Error!!!, Section Unavailable     '
else sysDesc="
Computer Manufacturer: $compManufacture
Computer description or model: $compDescription
Computer Serial Number: $compSerial"
fi

# if all data items in a section are unavailable, then an error is printed
if [[ "$cpumodel" == "$cpuArch" ]] && [[ "$cpuArch"  == "$cpuCore" ]] && [[ "$cpuCore" == "$cpuMaxSpeed" ]] && [[ "$cpuMaxSpeed"  == "$cpuCacheL1D" ]] && [[ "$cpuCacheL1D" == "$cpuCacheL1I" ]] && [[ "$cpuCacheL1I"  == "$cpuCacheL2" ]] && [[ "$cpuCacheL2" == "$cpuCacheL3" ]]; then
	cpuinfo='     Error!!!, Section Unavailable     '
else cpuinfo="
CPU Model: $cpumodel
CPU Architecture: $cpuArch
CPU core count: $cpuCore
CPU Maximum speed: $cpuMaxSpeed
Size of cache(L1d): $cpuCacheL1D
Size of cache(L1i): $cpuCacheL1I
Size of cache(L2): $cpuCacheL2
Size of cache(L3): $cpuCacheL3"
fi

# if all data items in a section are unavailable, then an error is printed
if [[  "$os" == "$distroVer" ]]; then
	osinfo='     Error!!!, Section Unavailable     '
else osinfo="
Linux Distro: $os
Distro version: $distroVer"
fi

cat <<EOF

Report content:
========================================

-----------System Description-----------

$sysDesc

========================================

-----------CPU Information--------------

$cpuinfo

========================================

------------OS Information--------------

$osinfo

========================================

EOF
