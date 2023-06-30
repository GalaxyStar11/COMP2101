#!/bin/bash
#demo for for
#generate a list of usernames for the end-user accounts

users="$(cut -d: -f1,3 /etc/passwd)"
for user in $users; do
	username=$(cut -d: -f1 <<< $user)
	userid=$(cut -d: -f2 <<< $user)
	if [ $userid -gt 999 ]; then
	#if variable exists, add username
		if [ ! -v allusers ]; then
			allusers="$username"
		else
	#if variable has some data, add the username to it at the end with a space in between
			allusers+=" $username"
		fi
	fi
done
echo "Found users: $allusers"
