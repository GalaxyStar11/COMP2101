
# Function library created for systeminfo script

# Variables created to store output of heavy commands
lshwOutput=$(lshw)
lscpuOutput=$(lscpu)
dmidecodeOutput=$(dmidecode)
lsblkOutput=$(lsblk)

#==================================================================================
# grep -m1 option is used to get the first match 
# grep -i option is used to ignore repetitive results and hits.
# [ NOTE: BOTH '-m1' AND '-i' ARE USED IN MAJORITY OF THE COMMANDS SO AS TO AVOID WRONG OUTPUTS. SOMETIMES USING A COMMAND OUTPUT STORED IN A VARIABLE RESULTS IN BROKEN OUTPUT, WHEN USING GREP. USING BOTH '-m1' AND '-i' NEGATES THIS.] 

# awk is used to print specific fields

# Function for Computer Report
function computerreport {
# ---------------------------	SYSTEM DESCRIPTION	---------------------------

# COMPUTER MANUFACTURER
# lshw command with the class 'system' is used to filter hardware.
# grep is used to get the 'vendor:' field
compManu=$(echo "$lshwOutput" -class system | grep -m1 -i "vendor:" | awk '{ $1=""; print $0 }')

# COMPUTER DESCRIPTION
compDesc=$(echo "$lshwOutput" -class system | grep -m1 -i "description:" | awk '{ $1=""; print $0 }')

# COMPUTER MODEL
compModel=$(echo "$lshwOutput" -class system | grep -m1 -i "product:" | awk '{ $1=""; print $0 }')

# COMPUTER SERIAL NUMBER
compSerial=$(echo "$lshwOutput" -class system | grep -m1 -i "serial:" | awk '{ $1=""; print $0 }')

# cat command is used to create an output template for the system report
cat << EOF
===========================      COMPUTER REPORT       ===========================

Computer Manufacturer:	$compManu

Computer Description:	$compDesc

Computer Model:		$compModel

Computer Serial number:	$compSerial
EOF
}

# Function for CPU report
function cpureport {
# ---------------------------	CPU INFORMATION 	---------------------------

# CPU MANUFACTURER
cpuManu=$(echo "$lshwOutput" -class cpu | grep -m1 -i "vendor:" | awk '{ $1=""; print $0 }')

# CPU MODEL
cpuModel=$(echo "$lscpuOutput" | grep -m1 -i "Model name:" | awk '{ $1=""; $2=""; print $0 }')

# CPU ARCHITECTURE
cpuArch=$(echo "$lscpuOutput" | grep -m1 -i "Architecture:" | awk '{ $1=""; print $0 }')

# CPU CORE COUNT
cpuCore=$(echo "$lscpuOutput" | grep -m1 -i "CPU(s):" | awk '{ $1=""; print $0 }')

# CPU MAXIMUM SPEED
cpuSpeed=$(echo "$lshwOutput" -class cpu | grep -m1 -i "capacity:" | awk '{ $1=""; print $0 }')

# CACHE SIZE
cpuCacheL1d=$(echo "$lscpuOutput" | grep -i "L1d cache:" | awk '{ print $3"KB" }')
cpuCacheL1i=$(echo "$lscpuOutput" | grep -i "L1i cache:" | awk '{ print $3"KB" }')
cpuCacheL2=$(echo "$lscpuOutput" | grep -i "L2 cache:" | awk '{ print $3"KB" }')
cpuCacheL3=$(echo "$lscpuOutput" | grep -i "L3 cache:" | awk '{ print $3"KB" }')

# cat command is used to create an output template for CPU report
cat << EOF
===========================        CPU REPORT        ===========================

CPU Manufacturer:	$cpuManu

CPU Model:	       $cpuModel

CPU Archtecture:	$cpuArch

CPU Core count:		$cpuCore

CPU Maximum Speed:	$cpuSpeed

CPU caches
	L1d:		 $cpuCacheL1d
	L1i:		 $cpuCacheL1i
	L2:		 $cpuCacheL2
	L3:		 $cpuCacheL3
EOF
}

# Function for OS Report
function osreport {
# ---------------------------	OS INFORMATION 		---------------------------

# LINUX DISTRO
linuxDistro=$(hostnamectl | grep "Operating System:" | awk '{ $1=""; $2="";  print $0 }')

# DISTRO VERSION
distroVer=$(hostnamectl | grep "Kernel:" | awk '{ $1=""; print $0 }')

# cat command to create an output template for OS Report
cat << EOF
===========================        OS REPORT         ===========================

Linux Distro:	      $linuxDistro

Distro Version:		$distroVer

EOF
}

# Function for RAM report
function ramreport {
# ---------------------------	RAM INFORMATION 	---------------------------

# RAM MANUFACTURER
ramManu=$(echo "$dmidecodeOutput" --type 17 | grep -m1 -i "Manufacturer:" | awk '{ $1=""; print $0 }')

# RAM SERIAL NUMBER
ramModel=$(echo "$dmidecodeOutput" | grep -m1 -i "Serial Number:" | awk '{ $1=""; $2=""; print $0 }')

# RAM PRODUCT NAME
ramProductName=$(echo "$dmidecodeOutput" | grep -m1 -i "Product" | awk '{ $1=""; $2=""; print $0 }')

# RAM SIZE
ramSize=$(echo "$lshwOutput" | grep -A5 "\-memory" | grep "size:" | awk '{ $1=""; print $0 }')

# RAM SPEED
ramSpeed=$(echo "$dmidecodeOutput" --type 17 | grep -m1 -i "Speed:" | awk '{ $1=""; $2=""; print $0 }' )

# RAM PHYSICAL LOCATION
ramPhyLocation=$(echo "$lshwOutput" | grep -m1 -i "slot: RAM" | awk '{ $1=""; $2=""; print $0 }')

# TOTAL SIZE OF RAM INSTALLED ( NOT IN TABLE )
ramTotalSize=$(echo "$lshwOutput" | grep -m1 -i -A5 "\-memory" | grep "size:" | awk '{ $1=""; print $0 }')

# cat command for output template for RAM report
cat << EOF
===========================        RAM REPORT         ===========================

RAM Manufacturer:	$ramManu

RAM Product Name:      $ramProductName

RAM Model:	       $ramModel

RAM Size:		$ramSize

RAM Speed:	       $ramSpeed

RAM Physical Location: $ramPhyLocation

Total RAM:		$ramTotalSize

EOF
}

# Function for Disk report
function diskreport {
# ---------------------------	DISK INFORMATION 	---------------------------

# DRIVE MANUFACTURER
driveManu=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-disk" | grep "vendor:" | awk '{ $1=""; print $0}')
# DRIVE MANUFACTURER VOLUME 0
driveManu0=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-volume:0" | grep "vendor:" | awk '{ $1=""; print $0}')
# DRIVE MANUFACTURER VOLUME 1
driveManu1=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-volume:1" | grep "vendor:" | awk '{ $1=""; print $0}')
# DRIVE MANUFACTURER VOLUME 2
driveManu2=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-volume:2" | grep "vendor:" | awk '{ $1=""; print $0}')

# DRIVE MODEL
driveModel=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-disk" | grep "product:" | awk '{ $1=""; print $0}')

# DRIVE SIZE
driveSize=$(echo "$lsblkOutput" | grep -m1 -i "sda" | awk '{ print $4"B" }')
# DRIVE SIZE VOLUME 0
driveSize0=$(echo "$lsblkOutput" | grep -m1 -i "sda1" | awk '{ print $4"B" }')
# DRIVE SIZE VOLUME 1
driveSize1=$(echo "$lsblkOutput" | grep -m1 -i "sda2" | awk '{ print $4"B" }')
# DRIVE SIZE VOLUME 2
driveSize2=$(echo "$lsblkOutput" | grep -m1 -i "sda3" | awk '{ print $4"B" }')

# PARTITION NUMBER VOLUME 0
drivePartNumber0=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-volume:0" | grep -m1 -i "logical name:" | awk '{ $1=""; print $0}')
# PARTITION NUMBER VOLUME 1
drivePartNumber1=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-volume:1" | grep -m1 -i "logical name:" | awk '{ $1=""; print $0}')
# PARTITION NUMBER VOLUME 2
drivePartNumber2=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-volume:2" | grep -m1 -i "logical name:" | awk '{ $1=""; print $0}')

# FILESYSTEM SIZE SDA 2
driveFileSystemSizeSDA2=$(df -h | grep -m1 -i "sda2" | awk '{ print $2"B" }')
# FILESYSTEM SIZE SDA 3
driveFileSystemSizeSDA3=$(df -h | grep -m1 -i "sda3" | awk '{ print $2"B" }')
# FILESYSTEM FREE SPACE SDA 2
driveFileSystemFreeSpaceSDA2=$(df -h | grep -m1 -i "sda2" | awk '{ print $4"B" }')
# FILESYSTEM FREE SPACE SDA 3
driveFileSystemFreeSpaceSDA3=$(df -h | grep -m1 -i "sda3" | awk '{ print $4"B" }')

# cat command is used to create an output template for disk report
cat << EOF
===========================        DISK REPORT         ===========================

Drive Manufacturer:	$driveManu
	Volume 0 Manufacturer:	$driveManu0
	Volume 1 Manufacturer:	$driveManu1
	Volume 2 Manufacturer:	$driveManu2

Drive Model:		$driveModel

Drive Size:		$driveSize
	Volume 0 Size:		$driveSize0
	Volume 1 Size:		$driveSize1
	Volume 2 Size:		$driveSize2

Partition for Volume 0: $drivePartNumber0
Partition for Volume 1: $drivePartNumber1
Partition for Volume 2: $drivePartNumber2

Filesystem Size:
	SDA 2:		$driveFileSystemSizeSDA2
	SDA 3:		$driveFileSystemSizeSDA3
	
Filesystem free space:
	SDA 2:		$driveFileSystemFreeSpaceSDA2
	SDA 3:		$driveFileSystemFreeSpaceSDA3

EOF
}

# Function for Video card Report
function videoreport {

# ---------------------------	VIDEO CARD INFORMATION	---------------------------

# VIDEOCARD MANUFACTURER
videoCardManu=$(echo "$lshwOutput" | grep -m1 -i -A5 "\-display" | grep "vendor:" | awk '{ $1=""; print $0 }')

# VIDEOCARD DESCRIPTION
videoCardDesc=$(echo "$lshwOutput" | grep -m1 -i -A5 "\-display" | grep "description:" | awk '{ $1=""; print $0 }')

# VIDEOCRD MODEL
videoCardModel=$(echo "$lshwOutput" | grep -m1 -i -A5 "\-display" | grep "product:" | awk '{ $1=""; print $0 }')

# cat command to create output template for video report
cat << EOF
===========================        VIDEO REPORT         ===========================

Videocard Manufacturer:	$videoCardManu

Videocard Model:	$videoCardModel

Videocard Description:	$videoCardDesc

EOF
}

# Function for network report
function networkreport {
# ---------------------------	NETWORK INFORMATION 	---------------------------

# INTERFACE MANUFACTURER
networkManu=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-network" | grep "vendor:" | awk '{ $1=""; print $0 }')

# INTERFACE MODEL
networkModel=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-network" | grep "product:" | awk '{ $1=""; print $0 }')

# INTERFACE DESCRIPTION
networkDesc=$(echo "$lshwOutput" | grep -m1 -i -A10 "\-network" | grep "description:" | awk '{ $1=""; print $0 }')

# INTERFACE LINK STATE
networkLinkState=$(ethtool ens33 | grep -m1 -i "Link detected:" | awk '{ print $3 }')

# INTERFACE CURRENT SPEED
networkSpeed=$(ethtool ens33 | grep -m1 -i "Speed:" | awk '{ print $2 }')

# INTERFACE IP ADDRESSES ( IN CIDR FORMAT IF CONFIGURED )
networkIPAddress=$(ip addr | grep -m1 -i -A10 "ens33:" | awk '{ FNR==4; print $2}' | awk 'FNR==4')

# cat command for output template of network report
cat << EOF
===========================        NETWORK REPORT         ===========================

Interface Manufacturer:	$networkManu

Interface Model:	$networkModel

Interface Description:	$networkDesc

Interface Line State:	$networkLinkState

Interface Current Speed:$networkSpeed

Interface IP Address:	$networkIPAddress

EOF
}

# ---------------------------------------------------------------------------------

# diskoption function is used to print only the diskreport when corresponding custom command line option is called (-d | --disk).
function diskOption {
diskreport
}

# networkoption function is used to print only the networkreport when corresponding custom command line option is called (-n | --network).
function networkOption {
networkreport
}

# systemoption function is used to print the system report(computerreport, cpureport, osreport, ramreport, and videoreport) when corresponding custom command line option is called (-s | --system).
function systemOption {
computerreport
osreport
cpureport
ramreport
videoreport
}

# verboseOption is called to run script verbosely and display the error message on the command line, when the corresponding command line option is called (-v | --verbose).
function verboseOption {
	local timeStamp
	timeStamp=$(date + " %Y - %a - %d: %T ")
	message="$1"
	>&2 echo "[$timeStamp]" "$message"
}

# Function for help, which displays the script syntax and explains the command line options
function helpfunction {
cat << EOF
======================        sysinfo.sh HELP         ======================

usage: sysinfo.sh [options]

Options Descriptions
-h | --help:		Display help
-v | --verbose:		Runs script verbosely, showing any encountered errors to the user
-s | --system:		Runs only computerreport, osreport, cpureport, ramreport, and videoreport
-d | --disk:		Runs only diskreport
-n | --network:		Runs only networkreport

EOF
}

# Function for error messgae which saves the errors to a specific file.
# it also creates the specific file, if it does not exist already
function errormessage {
	local timeStamp
	timeStamp=$(date +"%Y-%a-%d %T ")
	message="$1"
	if ! [ -e /var/log/systeminfo.log ]; then
		touch /var/log/systeminfo.log || echo "[$timeStamp]" "$message" >> /var/log/systeminfo.log
	else
		echo "[$timeStamp]" "$message" >> /var/log/systeminfo.log
	fi
	}
