#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
###############

#hostname variable for hostname
hostname=$(hostname)

#Title of the day using if statements
#Title for monday
if [[ $(date +%A) == 'Monday' ]]
then
	title='Start of Pain and Suffering'
fi
#Title for tuesday
if [[ $(date +%A) == 'Tuesday' ]]
then
	title='Wake up early'
fi
#Title for wednesday
if [[ $(date +%A) == 'Wednesday' ]]
then
	title='Mid week drinking'
fi
#Title for thursday
if [[ $(date +%A) == 'Thursday' ]]
then
	title='Almost done'
fi
#Title for friday
if [[ $(date +%A) == 'Friday' ]]
then
	title='Let"s goooo'
fi
#Title for saturday
if [[ $(date +%A) == 'Saturday' ]]
then
	title='Let"s go clubbing'
fi
#Title for sunday
if [[ $(date +%A) == 'Sunday' ]]
then
	title='Last day of week'
fi
###############
# Main        #
###############
cat <<EOF 

Welcome to planet $hostname, "$title $USER!"
It is $(date +%A) at $(date +%R) $(date +%p)

EOF
 
