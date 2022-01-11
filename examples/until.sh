#!/bin/sh

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 41
# simple demonstration of 'until' control structure
i=5

until [ $i == 0 ]; do
	echo "here we go again, ..."
	i=$(($i-1))
done
