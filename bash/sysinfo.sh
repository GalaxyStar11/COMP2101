#!/bin/bash
#echo commands are used to display labels

#Hostname command with "-f" option to display the fqdn information only
fqdn=$(hostname -f)

#hostnamectl command to display OS info with awk command to only get the required data
#FNR == 7 is used for selecting the line 7 and print $3, $4, $5 is used to print the 3rd, 4th, and 5th item field
hostname=$(hostnamectl | awk 'FNR == 7 {print $3, $4, $5}')

#hostname command with uppercase "-I" option to display IP address
ip=$(hostname -I)

# df command with '/' for root directory and "-h" option for human readable format with awk command to get only the required data
#FNR == 2 is used for choosing the line 2 and print $4 prints the 4th item field
freespace=$(df / -h | awk 'FNR == 2 {print $4}')


cat <<EOF

Report
========================================
FQDN: $fqdn
Operating System name and version: $hostname
IP Address: $ip
Root Filesystem Free Space: $freespace
========================================

EOF
