#!/bin/bash

# Testing if the script is run with root privilage and if not, exit
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for this script";
	exit 1
fi

# Sourcing the function library to load functions and variables
source reportfunctions.sh

# Variables made to store output from commands
lshwOutput=$(lshw)
lscpuOutput=$(lscpu)
demidecodeOutput=$(dmidecode)
lsblkOutput=$(lsblk)


##########################################################################

# variables created to determine the script behaviour
verbose=false
systemReport=false
diskReport=false
networkReport=false
fullReport=true


# While loop created to filter and go through commands
while [ $# -gt 0 ]; do
	# case command is used to create options for the script
	case ${1} in
		# -h \ --help option displays the help function
		# displayhelp function is called
		-h | --help)
		displayHelp
		exit 0
		;;
		# -v \ --verbose option to run script verbosely.
		# verbose variable value is changed to true
		-v | --verbose)
		verbose=true
		;;
		# -s \ --system option to display only system report
		# systemReport variable value is changed to true
		-s | --system)
		systemReport=true
		;;
		# -d \ --disk option to display only disk report
		# diskReport variable value is changed to true
		-d | --disk)
		diskReport=true
		;;
		# -n \ --network option to display only network report
		# networkReport variable value is changed to true
		-n | --network)
		networkReport=true
		;;
		# any other option except the ones mentioned above give a error
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

# If statements are used to check the options requested by user on the command line, which is done by comparing the values of variables created for script behaviour

# If verbose value is true, then script is run verbosely and errors are displayed to user
if [[ "$verbose" == true ]]; then
	fullReport=false
	errorMessage
fi

# if systemreport variable is true, then only computer info, cpu info, os info, ram info, and video card info are displayed
if [[ "$systemReport" == true ]]; then
	fullReport=false
	computerreport
	osreport
	cpureport
	ramreport
	videoreport
fi

# if diskreport variable is true, then only disk information is displayed
if [[ "$diskReport" == true ]]; then
	fullReport=false
	diskreport
fi

# if networkreport variable is true, then only network interface information is displayed
if [[ "$networkReport" == true ]]; then
	fullReport=false
	networkreport
fi

# if no options are selected or inputed by user, then full report is displayed
if [[ "$fullReport" == true ]]; then
    computerreport
    osreport
    cpureport
    ramreport
    videoreport
    diskreport
    networkreport
fi
