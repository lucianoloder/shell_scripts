#/bin/bash

# \brief This code implements a brute-force caesar cypher using BASH command-line TR
# \params $1 text to be deciphered/ciphered

########################################
# input parsing
########################################
if [ -z "$1" ] ; then
	echo " usage: $0 <message>"
	exit 0
fi

MESSAGE=$1

original='abcdefghijklmnopqrstuvwxyz'
uppercase_original=$(echo ${original} | tr '[:lower:]' '[:upper:]' )

for ((i=0; i<25; ++i)); do
	echo "${original:$i:1} - $(echo ${MESSAGE} \
		| tr ${original:$i}${original:0:$i} ${original} \
		| tr ${uppercase_original:$i}${uppercase_original:0:$i} ${uppercase_original} )"
done;

# using filenames as input/output
#FILENAME='/krypton/krypton2/krypton3'
#OUTPUT_FILE="modified.txt"
#for ((i=0; i<25; ++i)); do cat ${FILENAME}  | tr ${original} ${original:$i}${original:0:$i} >> ${OUTPUT_FILE}; done;

