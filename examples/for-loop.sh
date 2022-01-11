#!/bin/bash

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 37
#portable method, can be used with seq command
for i in /bin/* ; do
	echo $i
done

# Alternative method, may not work with non-bash shells
# Debian and debian-based distros use dash, that prompts
# an error when using this kind of for loop

for ((i=0; i<5; ++i)); do
	echo $i
done
exit 0
