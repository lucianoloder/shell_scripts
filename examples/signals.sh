#/bin/sh

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 60
# Simple example of signal processing in BASH

# When CTRL-C  (SIGINT)is pressed, it echoes a
# message and interrupts the processing

trap 	'echo kids ; exit ' SIGINT

while : ; do 
	echo hi
	sleep 1
done
