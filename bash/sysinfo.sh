#!/bin/bash

# Testing if the script is run with root privilage.
# If not, the script is exited
if ! [ "$(whoami)" = "root" ]; then
	echo "You must have root privilage to run this script;
	Try 'sudo' sysinfo.sh";
	   exit 1
fi

# Sourcing the function library to load functions and variables for use in the script
source reportfunctions.sh

# Variable created for default script behaviour, which runs all the report functions
fullReport=true


#----------------------------------------------------

# While loop created to filter and go-trough all the command options
while [ $# -gt 0 ]; do
	
	# case command is used to create custom command line options for the script
	case ${1} in
	# --help | -h command line option displays the help function
	--help | -h)
	helpfunction
	exit 0
	# default script behaviour variable is changed to false, hence not displaying the reports
	fullReport=false
	;;
	# --verbose | -v option runs the script verbosely and prints the error message on the command line
	--verbose | -v)
	fullReport=false
	$timeStamp
	timeStamp=$(date +"%Y-%a-%d %T")
	message="$1"
	>&2 echo "[$timeStamp]" "$message"
	exit 0
	;;
	# --system | -s option runs only the system reports (computerreport, cpureport, osreport, ramreport, and videoreport)
	--system | -s)
	fullReport=false
	# systemOption function is called
	systemOption
	;;
	# --disk | -d option runs only the diskreport
	--disk | -d)
	fullReport=false
	# diskOption function is called
	diskOption
	;;
	# --network | -n option runs only the networkreport
	--network | -n)
	fullReport=false
	# networkoption function is called
	networkOption
	;;
	# Any other character other than the above mentioned options, displays an error and exits the script.
	*)
	fullReport=false
	echo "Invalid Option
	usage: sysinfo.sh [options]
	try 'sysinfo.sh --help' for more information"
	errormessage "$@"
	exit 1
	;;
	esac
	shift
done

# If no command line option is entered, the default script, which inlcudes all the reports runs
if [[ "$fullReport" == true ]]; then
	computerreport
	osreport
	cpureport
	ramreport
	videoreport
	diskreport
	networkreport
fi
