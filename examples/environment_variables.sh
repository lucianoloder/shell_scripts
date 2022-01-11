#/bin/bash

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 31
# These are some variables set by default on the shell command-line
# A list of all variables from a shell is obtained with the program
# printenv()
#
# Some of these variables are set in ~/.bashrc (for the local user)
# others in /etc/bash.bashrc (for all users).

echo " home directory is $HOME"
echo " the default path is $PATH"
echo " The default command prompt is $PS1"
echo " The secondary command prompt is $PS2"
echo " The input field separator - IFS is $IFS"
echo " The name of this shell script is $0"
echo " The number of arguments passed is $#"
echo " The PID of this shell is $$"
echo " All the variables passed to this script are $*"

