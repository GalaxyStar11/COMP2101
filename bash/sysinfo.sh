#!/bin/bash
#echo commands are used to display labels

#Testing if the script is run with root privilage and if not, exit
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for this script";
	exit 1
fi

lshwOutput=$(lshw)
lscpuOutput=$(lscpu)
demidecodeOutput=$(dmidecode)
lsblkOutput=$(lsblk)
################ System Description ######################

#lshw command used with class "system" to filter system hardware
#grep is used to get 'description' field, while awk is used to print the 2nd itme field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
compDescription=$(echo "$lshwOutput" -class system | grep -m1 -i 'description:' | awk '{print $2}')
if [ -z "$compDescription" ]; then 
	compDescription='"Error!!!" Data is unavailable'
else compDescription=$(echo "$lshwOutput" -class system | grep -m1 -i 'description:' | awk '{print $2}')
fi

#lshw command used with class "system" to filter system hardware
#grep is used to get 'vendor' field, while awk is used to print all the fields after field 1
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
compManufacture=$(echo "$lshwOutput" -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}')
if [ -z "$compManufacture" ]; then
	compManufacture='"Error!!!" Data is unavailable'
else compManufacture=$(echo "$lshwOutput" -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}')
fi

#lshw command used with class "system" to filter system hardware
#grep is used to get 'serial:' field, while awk is used to print all the fields after field 1
#-z test command is used to check if the data is available or not' by testing the variable and checking if it's empty or not. If empty an error is displayed
compSerial=$(echo "$lshwOutput" -class system | grep -m1 -i 'serial:' | awk '{$1=""; print $0}')
if [ -z "$compSerial" ]; then
	compSerial='"Error!!!" Data is unavailable'
else compSerial=$(echo "$lshwOutput" -class system | grep -m1 -i 'serial:' | awk '{$1=""; print $0}')
fi

################# CPU Information ######################

#lscpu command is used which gives CPU information
#grep is used to get 'Model name:' field, while 
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpumodel=$(echo "$lscpuOutput" | grep 'Model name:' | sed 's/,*Model name: *//')
if [ -z "$cpumodel" ]; then
	cpumodel='"Error!!! Data is unavailable'
else cpumodel=$(echo "$lscpuOutput" | grep 'Model name:' | sed 's/,*Model name: *//')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'Architecture:' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuArch=$(echo "$lscpuOutput" | grep 'Architecture:' | awk '{print $2}')
if [ -z "$cpuArch" ]; then
	cpuArch='"Error!!! Data is unavailable'
else cpuArch=$(echo "$lscpuOutput" | grep 'Architecture:' | awk '{print $2}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'CPU(s):' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCore=$(echo "$lscpuOutput" | grep 'CPU(s):' | head -1 | awk '{print $2}')
if [ -z "$cpuCore" ]; then
	cpuCore='"Error!!! Data is unavailable'
else cpuCore=$(echo "$lscpuOutput" | grep 'CPU(s):' | head -1 | awk '{print $2}')
fi

#lshw command used with class "cpu" to filter cpu hardware
#grep is used to get 'capacity::' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuMaxSpeed=$(echo "$lshwOutput" -class cpu | grep 'capacity:' | head -1 | awk '{print $2}')
if [ -z "$cpuMaxSpeed" ]; then
	cpuMaxSpeed='"Error!!! Data is unavailable'
else cpuMaxSpeed=$(echo "$lshwOutput" -class cpu | grep 'capacity:' | head -1 | awk '{print $2}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L1d' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL1D=$(echo "$lscpuOutput" | grep 'L1d' | awk '{print $3}')
if [ -z "$cpuCacheL1D" ]; then
	cpuCacheL1D='"Error!!! Data is unavailable'
else cpuCacheL1D=$(echo "$lscpuOutput" | grep 'L1d' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L1i' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL1I=$(echo "$lscpuOutput" | grep 'L1i' | awk '{print $3}')
if [ -z "$cpuCacheL1I" ]; then
	cpuCacheL1I='"Error!!! Data is unavailable'
else cpuCacheL1I=$(echo "$lscpuOutput" | grep 'L1i' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L2' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL2=$(echo "$lscpuOutput" | grep 'L2' | awk '{print $3}')
if [ -z "$cpuCacheL2" ]; then
	cpuCacheL2='"Error!!! Data is unavailable'
else cpuCacheL2=$(echo "$lscpuOutput" | grep 'L2' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L3' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL3=$(echo "$lscpuOutput" | grep 'L3' | awk '{print $3}')
if [ -z "$cpuCacheL3" ]; then
	cpuCacheL3='"Error!!! Data is unavailable'
else cpuCacheL3=$(echo "$lscpuOutput" | grep 'L3' | awk '{print $3}')
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

########################  RAM INFORMATION #######################
ramManufacturer=$(echo "$demidecodeOutput" | grep -m1 -i "manufacturer" | awk '{$1=""; print $0}')
ramProductName=$(echo "$demidecodeOutput" | grep -m1 -i "Product name" | awk '{$1=""; $2=""; print $0}')
ramSerialNum=$(echo "$demidecodeOutput" | grep -m1 -i "serial number" | awk '{$1=""; $2=""; print $0}')
ramSize=$(echo "$lshwOutput" | grep -A10 "\-memory" | grep 'size:' | awk 'FNR == 2 {$1=""; print $0}')
ramSpeed=$(echo "$demidecodeOutput" --type 17 | grep -m1 Speed | awk '{ $1=""; print $0 }')
ramLocation=$(echo "$lshwOutput" | grep -m1 'slot: RAM' | awk '{$1=""; $2=""; print $0}')
totalSize=$(echo "$lshwOutput" | grep -A5 "\-memory" | grep -m1 'size:' | awk '{$1=""; print $0}')
ramtable=$(paste -d ';' <(echo "$ramManufacturer") <(echo "$ramProductName") <(
echo "$ramSerialNum") <(echo "$ramSize") <(echo "$ramSpeed") <(echo "$ramLocation") <(
echo "$totalSize") | column -N Manufacturer,Model,'Serial Num',Size,Speed,Location,'Total Size' -s ';' -o ' | ' -t)

#a table of the installed memory components (DIMMs, SODIMMs, etc.) with each table row having:
#component manufacturer
#component model/product name
#component size in human readable format
#component speed in human readable format
#component physical location in human readable format
#total size of installed ram in human readable format


########################  STORAGE INFORMATION  ##################
driveManufacturer0=$(echo "$lshwOutput" | grep -A10 '\*\-disk' | grep 'vendor:' | awk '{print $2}')

driveVendor1=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:0" | grep "vendor:" | awk '{$1=""; print $0}')
driveVendor2=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:1" | grep "vendor:" | awk '{$1=""; print $0}')
driveVendor3=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:2" | grep "vendor:" | awk '{$1=""; print $0}')

driveModel=$(echo "$lshwOutput" | grep -m1 -A10 "\-disk" | grep "product:" | awk '{$1=""; print $0}')

driveSize0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $4"B"}')
driveSize1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $4"B"}')
driveSize2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $4"B"}')
driveSize3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $4"B"}')

drivePartition0=$(echo "$lsblkOutput" | grep -w "sda" | awk '{print $1}')
drivePartition1=$(echo "$lsblkOutput" | grep -w "sda1" | awk '{print $1}' | tail -c 5)
drivePartition2=$(echo "$lsblkOutput" | grep -w "sda2" | awk '{print $1}' | tail -c 5)
drivePartition3=$(echo "$lsblkOutput" | grep -w "sda3" | awk '{print $1}' | tail -c 5)

driveMountPoint0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $7}')
driveMountPoint1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $7}')
driveMountPoint2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $7}')
driveMountPoint3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $7}')

driveFilesystemSizeSDA2=$(df -h | grep "sda2" | awk '{print $2"B"}')
driveFilesystemSizeSDA3=$(df -h | grep "sda3" | awk '{print $2"B"}')

driveFilesystemFreeSDA2=$(df -h | grep "sda2" | awk '{print $4"B"}')
driveFilesystemFreeSDA3=$(df -h | grep "sda3" | awk '{print $4"B"}')

diskTable=$(paste -d ';' <(echo "$drivePartition0" ; echo "$drivePartition1" ; echo "$drivePartition2" ; echo "$drivePartition3" ) <( 
echo "$driveManufacturer0" ; echo "$driveVendor1" ; echo "$driveVendor2" ; echo "$driveVendor3" ) <( 
echo "$driveModel" ; echo "N/A" ; echo "N/A" ; echo "N/A") <( 
echo "$driveSize0" ; echo "$driveSize1" ; echo "$driveSize2" ; echo "$driveSize3" ) <( 
echo "N/A" ; echo "N/A" ; echo "$driveFilesystemSizeSDA2" ; echo "$driveFilesystemSizeSDA3" ) <( 
echo "N/A" ; echo "N/A" ; echo "$driveFilesystemFreeSDA2" ; echo "$driveFilesystemFreeSDA3" ) <( 
echo "$driveMountPoint0" ; echo "$driveMountPoint1" ; echo "$driveMountPoint2" ; echo "$driveMountPoint3" ) | column -N 'Logical Name (/dev/sda)',Vendor,Model,Size,'Filesystem Size','Filesystem Free Space','Mount Point' -s ';' -o ' | ' -t)
#a table of the installed disk drives with each table row having:
#Drive manufacturer
#Drive model
#Drive size in a human friendly format
#Partition number
#Mount point if mounted
#Filesystem size in a human friendly format if filesystem is mounted
#Filesystem free space in a human friendly format if filesystem is mounted


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

-----------RAM Information--------------

$ramtable

========================================

--------Disk Storage Information--------

$diskTable

=========================================

EOF
