#!/bin/bash


#This is a guessing game to pick a num from 1-10

#generate a secret number
secNum=$((RANDOM % 10 + 1))

#ask user to guess
while read -p "Pick a num from 1 to 10:  " usrguess; do

	#did they get it right? if not, go back and try again

	#Make sure, we get some input
	if [ -z "$usrguess" ]; then
		echo "You must enter a number"
		exit
	fi
	
	#give hints
	if [ "$usrguess" -lt "$secNum" ]; then
		echo "You were too low, guess higher"
		continue
	elif [ "$usrguess" -gt "$secNum" ]; then
		echo "You were too high, guess lower"
		continue
	else
	#end the game if won
		break
	fi
done

echo 'You won!!!!!'
