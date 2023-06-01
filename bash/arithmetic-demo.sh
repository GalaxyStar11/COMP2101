#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

# Asking the user for three numbers
read -p "Enter number 1: " firstnum
read -p "Enter number 2: " secondnum
read -p "Enter number 3: " thirdnum


# Calculating the sum of 3 user entered numbers
sum=$((firstnum + secondnum + thirdnum))
# Calculating the product of the 3 user entered numbers
product=$((firstnum * secondnum * thirdnum))

#Displaying the results
cat <<EOF
 $firstnum plus $secondnum plus $thirdnum is $sum
 $firstnum times $secondnum times $thirdnum is $product
EOF

