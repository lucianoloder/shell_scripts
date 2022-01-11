#/bin/bash

# if examples. Theyy depend on the [ command to
# return true or false statements.

if [ -f /bin/bash ] 
then
	echo "Bash was found"
else
	echo "Bash is lost!"
fi

TERMINAL="/bin/bash"

if [ -z ${TERMINAL} ]; then
	echo "TERM variable is not set "
elif [ -d ${TERMINAL} ]; then
	echo "bash is a directory???"
else
	echo "bash is NOT a directory."
fi
