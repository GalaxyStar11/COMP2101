#!/bin/bash

# This script demonstrates how to trap signals and handle them using functions

# Task: Add traps for the INT and QUIT signals. If the script receives an INT signal,
#       reset the count to the maximum and tell the user they are not allowed to interrupt
#       the count. If the script receives a QUIT signal, tell the user they found the secret
#       to getting out of the script and exit immediately.

#### Variables
programName="$0" # used by error_functions.sh
sleepTime=1 # delay used by sleeptime
numberOfSleeps=10 # how many sleeps to wait for before quitting for inactivity

#### Functions

# This function will send an error message to stderr
# Usage:
#   error-message ["some text to print to stderr"]
#
function error-message {
        local prog=`basename $0`
        echo "${prog}: ${1:-Unknown Error - a moose bit my sister once...}" >&2
}

# This function will send a message to stderr and exit with a failure status
# Usage:
#   error-exit ["some text to print" [exit-status]]
#
function error-exit {
        error-message "$1"
        exit "${2:-1}"
}
function usage {
        cat <<EOF
Usage: ${programName} [-h|--help ] [-w|--waittime waittime] [-n|--waitcount waitcount]
Default waittime is 1, waitcount is 10
EOF
}

# Normally traps catch signals and do something useful or necessary with them


# Produce the numbers for the countdown
function doCountdown {
while [ $sleepCount -gt 0 ]; do
    echo $((sleepCount * 100 / $numberOfSleeps))
    sleepCount=$((sleepCount - 1))
    sleep $sleepTime
done
}

#### Main Program

# Process command line parameters
while [ $# -gt 0 ]; do
    case $1 in
        -w | --waittime )
            shift
            sleepTime="$1"
            ;;
        -n | --waitcount)
            shift
            numberOfSleeps="$1"
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            error-exit "$1 not a recognized option"
    esac
    shift
done

if [ ! $numberOfSleeps -gt 0 ]; then
    error-exit "$numberOfSleeps is not a valid count of sleeps to wait for signals"
fi

if [ ! $sleepTime -gt 0 ]; then
    error-exit "$sleepTime is not a valid time to sleep while waiting for signals"
fi

sleepCount=$numberOfSleeps

doCountdown|dialog --gauge "Remaining Time" 7 60
stty sane

echo "Wait counter expired, exiting peacefully"
