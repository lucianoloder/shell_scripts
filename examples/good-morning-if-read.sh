#/bin/bash

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 31
# Simple if/elif demonstration, with terminal reading

echo "Is it morning? (yes or no) : "

read timeofday

if [ $timeofday = "yes" ]; then 
	echo "good morning ! good morning! "
elif [ $timeofday = "no" ]; then 
	echo " good night"
else
	echo "unknown answer - sorry!"
	exit 1
fi
exit 0
