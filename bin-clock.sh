#/bin/bash
# Simple script, to demonstrate the binclock shell command.
# It always does the following:
# - Prints the current time, using date
# - Prints the current time in binary form, using binclock
# - Prints the current time in binary, in columns, colored, using binclock
# - Clears the screen
#
# example:
# 	19:28:14
# 	010011 : 011100 : 01110
# 	0 1 0 1 0 0 
# 	0 0 0 0 0 1 
# 	0 0 1 0 0 0 
# 	1 1 0 0 1 0 


while (true) do
	clear;
	date +"%H:%M:%S";
	binclock -t;
	binclock;
	sleep 1;
done
