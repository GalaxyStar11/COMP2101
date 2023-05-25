#!/bin/bash
#
# this script rolls a pair of six-sided dice and displays both the rolls
#

# Task 1:
#  put the number of sides in a variable which is used as the range for the random number
#  put the bias, or minimum value for the generated number in another variable
#  roll the dice using the variables for the range and bias i.e. RANDOM % range + bias

# Task 2:
#  generate the sum of the dice
#  generate the average of the dice

#  display a summary of what was rolled, and what the results of your arithmetic were

# Tell the user we have started processing
echo "Rolling..."
# Variable for range for the number of sides
range=6
# Variable for bias, or minimum value for the generated number
bias=1

# roll the dice and save the results
die1=$(( RANDOM % range + bias ))
die2=$(( RANDOM % range + bias ))
# display the results
echo "Rolled $die1, $die2"

# Sum of the dice
sum=$((die1 + die2))
echo "The sum of the dice is $sum"

# Average of the dice
average=$((sum/2))
echo "The average of the dice is $average"
