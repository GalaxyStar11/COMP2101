#!/bin/bash

declare -a myvar
#while read; do myvar+=("$REPLY"); done < <(cut -d: -f1 /etc/passwd)


user="$(cut -d: -f1 /etc/passwd)"
while read; do
	myvar+=("$REPLY")
done <<< "$user"

#cut -d: -f1 /etc/passwd | while read; do
#	myvar+=("$REPLY")
#done

#echo "${#myvar[@]}"
#echo "${myvar[0]}"
#echo "${myvar[2]}"
echo "Muvar has ${#myvar[@]} elements"
for (( index=0; index < ${#user[0]}; index++ )); do
	echo index $index is ${user[$index]}
done
