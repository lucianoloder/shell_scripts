#!/bin/bash

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 39
# simple demonstration of 'while' control structure
foo=1

while [ "$foo" -le 20 ]; do
	echo "here we go again"
	# increment a numerical variable in shell
	foo=$(($foo+1))
done
exit 0
