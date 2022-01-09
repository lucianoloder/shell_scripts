#/bin/bash

# \brief This code implements the caesar cypher using BASH command-line TR
# \params $1 key, as a single char
# \params $2 text to be deciphered/ciphered
# \params $3 (c)ipher or (d)ecipher

# To perform a brute-force caesar cypher attack with this code:
#for i in {a..z}; do echo "$i - $(./cesar.sh $i 'geiwev gctliv' 'd')" ; done;

########################################
# input parsing
########################################
if [ -z "$3" ] ; then
	echo " usage: $0 <letter> <message> <c/d>"
	exit 0
fi

KEY=$1
INPUT=$2
MODE=$3

# converts the letter received to decimal via printf
SHIFT=$(printf '%d-%d\n' "'${KEY}'" "'a'" | bc)

########################################
# alphabet creation
########################################

A1='abcdefghijklmnopqrstuvwxyz'
A2=${A1:${SHIFT}}${A1:0:${SHIFT}}

if [ ${MODE} == 'c' ]; then
	original=${A1}
	key=${A2}
elif [ ${MODE} == 'd' ]; then
	original=${A2}
	key=${A1}
else
	echo "unkown mode: ${MODE}, aborting"
	exit 0
fi

uppercase_original=$(echo ${original} | tr '[:lower:]' '[:upper:]' )
uppercase_key=$(echo ${key} | tr '[:lower:]' '[:upper:]' )

########################################
# Caesar cypher substitution
########################################
# The middle TR converts uppercase to lowercase
# The second translates the text from the original to the cryptographic form

# Using variables as input/output
echo  ${INPUT} | tr ${uppercase_original} ${uppercase_key}  | tr ${original} ${key}

# using filenames as input/output
#FILE_NAME="alice-in-wonderland.txt"
#OUTPUT_FILE="modified.txt"
#cat ${FILE_NAME} | tr ${uppercase_original} ${uppercase_key}  | tr ${original} ${key} > ${OUTPUT_FILE}

#echo "Done, output written to ${OUTPUT_FILE}."

