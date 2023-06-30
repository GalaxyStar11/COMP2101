#!/bin/bash
#echo commands are used to display labels

#Testing if the script is run with root privilage and if not, exit
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for this script";
	exit 1
fi

source reportfunctions.sh

lshwOutput=$(lshw)
lscpuOutput=$(lscpu)
demidecodeOutput=$(dmidecode)
lsblkOutput=$(lsblk)


##########################################################################

verbose=false
systemReport=false
diskReport=false
networkReport=false
fullReport=true


while [ $# -gt 0 ]; do
	case ${1} in
		-h | --help)
		displayHelp
		exit 0
		;;
		-v | --verbose)
		verbose=true
		;;
		-s | --system)
		systemReport=true
		;;
		-d | --disk)
		diskReport=true
		;;
		-n | --network)
		networkReport=true
		;;
		*)
		echo "Invalid option
		Usage: sysinfo.sh [Options]
		try 'sysinfo.sh --help' for information"
		errorMessage "$@"
		exit 1
		;;
	esac
	shift
done

if [[ "$verbose" == true ]]; then
	fullReport=false
	errorMessage
fi

if [[ "$systemReport" == true ]]; then
	fullReport=false
	computerreport
	osreport
	cpureport
	ramreport
	videoreport
fi

if [[ "$diskReport" == true ]]; then
	fullReport=false
	diskreport
fi

if [[ "$networkReport" == true ]]; then
	fullReport=false
	networkreport
fi

if [[ "$fullReport" == true ]]; then
    computerreport
    osreport
    cpureport
    ramreport
    videoreport
    diskreport
    networkreport
fi
