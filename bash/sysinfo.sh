#!/bin/bash
#echo commands are used to display labels

echo "FQDN:"
#Hostname command with "-f" option to display the fqdn information only
hostname -f

echo "Host Information:"
#hostnamectl command to display OS info
hostnamectl

echo "Ip Addresses:"
#hostname command with uppercase "-I" option to display IP address
hostname -I

echo "Root space status:"
# df command with '/' for root directory and "-h" option for human readable format
df / -h
