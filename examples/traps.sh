#!/bin/bash

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 60
# Simple usage of command-line 'trap' to receive signals from terminal, such
# as SIGINT (CTRL-C), in this case

trap 'echo "removing file /tmp/my_tmp_file_$$";\
	rm -f /tmp/my_tmp_file_$$' INT

echo creating file /tmp/my_tmp_file_$$

date > /tmp/my_tmp_file_$$

echo "press interrupt (CTRL-C) to interrupt"

while [ -f /tmp/my_tmp_file_$$ ] ; do
	echo "file exists: /tmp/my_tmp_file_$$"
	sleep 1
done
echo the file no longer exists

# Define 
trap INT

exit 0
