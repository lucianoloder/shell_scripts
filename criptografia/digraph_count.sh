#!/bin/bash

# \brief This code implements a multiple-letter frequency analysis using command-line tools
# \params $1 file to be analyzed
# \params $2 top results to be shown - optional

########################################
# input parsing
########################################
if [ -z "$1" ] ; then
	echo " usage: $0 <filename> <top results - optional>"
	exit 0
fi

FILE_NAME=$1
TOP_RESULTS=$2
THRESHOLD=2
#FILE_NAME="/home/luciano/Documentos/ifsul/criptografia-e-seguranca-de-dados/programas/alice-in-wonderland.txt"
echo "parsing file ${FILE_NAME}"

TOTAL_CHARS=$(cat ${FILE_NAME} | wc -c)
echo "TOTAL CHARS ARE ${TOTAL_CHARS}"

########################################
# Functions definitions
########################################

# https://www.linuxjournal.com/content/return-values-bash-functions


# count a single character occurrence in the text
count_single_match()
{
	FILENAME=$1
	THRESHOLD=$2
	MATCH=$3
	#echo ${FILENAME} ${THRESHOLD} ${MATCH}
	# count the ocurrences
	COUNT=$(grep --ignore-case --only-matching  ${MATCH} ${FILENAME} | wc -l)
	if [ ${COUNT} -ge ${THRESHOLD} ]; then
		#TOTAL="${TOTAL}"$'\n'"${COUNT} - sequencia ${MATCH}";
		TOTAL="${COUNT} - sequence ${MATCH}";
		echo "${TOTAL}"
	fi
}

# count any N letter repetition occurrence in the text
# Uses count_single_match function
# For now we are only measuring 2-letter repetition,
# but the same code can show 3 or more letter repetition

count_letter_repetition()
{
	FILENAME=$1
	TOTAL=''
	THRESHOLD=$2
	CHAR_COUNT=$3
	TEMP=''

	for i in {a..z} ; do
		#create the match
		MATCH=''
		for ((r=0; r<${CHAR_COUNT}; ++r)); do MATCH=${MATCH}$i; done;

		# count the ocurrences using a dedicated function
		TEMP="$(count_single_match ${FILE_NAME} ${THRESHOLD} ${MATCH})"
		if [ -z "${TEMP}" ]; then continue; fi
		TOTAL+="${TEMP}"$'\n'
	done;
	echo "$TOTAL" | sort -h
}

########################################
# Main code
########################################

CHAR_COUNT=2
repetitive=$(count_letter_repetition ${FILE_NAME} ${THRESHOLD} ${CHAR_COUNT})

echo "################################################################################"
echo " ${CHAR_COUNT} leter repetition above ${THRESHOLD}" - top ${TOP_RESULTS} results
echo "################################################################################"

if [ -z "$2" ${TOP_RESULTS}] ; then
	echo "${repetitive}"
else
	echo "${repetitive}" | tail -n ${TOP_RESULTS}
fi

### old code ###
#repetitive letters
#TOTAL_DOUBLE_LETTER=''
#DOUBLE_LETTER_THRESHOLD=10
#for i in {a..z} ; do
#	double_letter_count=$(grep --ignore-case --only-matching  $i$i ${FILE_NAME} | wc -l)
#	if [ ${double_letter_count} -le ${DOUBLE_LETTER_THRESHOLD} ]; then continue; fi
#	TOTAL_DOUBLE_LETTER="${TOTAL_DOUBLE_LETTER}"$'\n'"${double_letter_count} - sequencia $i$i";
#done;
#echo "$TOTAL_DOUBLE_LETTER" | sort -h

########################################
# count all digraph repetition occurrence in the text
########################################
TOTAL_DIGRAPH=''
# hard-coded threshold - depends on the number of chars of the input text
#DIGRAPH_THRESHOLD=10
# threshold proportional to the number of chars of the input text
DIGRAPH_THRESHOLD=$(echo "${TOTAL_CHARS} / 100" | bc)

for i in {a..z} ; do
	for j in {a..z} ; do
		digraph_count=$(grep --ignore-case --only-matching  $i$j ${FILE_NAME} | wc -l)
		#echo ${digraph_count}
		if [ ${digraph_count} -le ${DIGRAPH_THRESHOLD} ]; then continue; fi

		TOTAL_DIGRAPH="${TOTAL_DIGRAPH}"$'\n'"${digraph_count} - digraph $i$j";
	done;
done;

echo "################################################################################"
echo " Digraph leter repetition above ${DIGRAPH_THRESHOLD} - top ${TOP_RESULTS} results"
echo "################################################################################"

if [ -z "$2" ${TOP_RESULTS}] ; then
	echo "$TOTAL_DIGRAPH" | sort -h
else
	echo "$TOTAL_DIGRAPH" | sort -h | tail -n ${TOP_RESULTS}
fi


########################################
# count all trigraph repetition occurrence in the text
########################################
TOTAL_TRIGRAPH=''
# hard-coded threshold - depends on the number of chars of the input text
# TRIGRAPH_THRESHOLD=2
# threshold proportional to the number of chars of the input text
TRIGRAPH_THRESHOLD=$(echo "${TOTAL_CHARS} / 400" | bc)

# trigraph count 
for i in {a..z} ; do
	for j in {a..z} ; do
	for k in {a..z} ; do
		trigraph_count=$(grep --ignore-case --only-matching  $i$j$k ${FILE_NAME} | wc -l)
		#echo ${trigraph_count}
		if [ ${trigraph_count} -le ${TRIGRAPH_THRESHOLD} ]; then continue; fi

		TOTAL_TRIGRAPH="${TOTAL_TRIGRAPH}"$'\n'"${trigraph_count} - trigraph $i$j$k";
	done;
done;
done;

echo "################################################################################"
echo " Trigraph leter repetition above ${TRIGRAPH_THRESHOLD} - top ${TOP_RESULTS} results"
echo "################################################################################"

if [ -z "$2" ${TOP_RESULTS}] ; then
	echo "$TOTAL_TRIGRAPH" | sort -h
else
	echo "$TOTAL_TRIGRAPH" | sort -h | tail -n ${TOP_RESULTS}
fi



#$ ./digraph_count.sh 
#parsing file /home/luciano/Documentos/ifsul/criptografia-e-seguranca-de-dados/programas/alice-in-wonderland.txt
################################################################################
# 2 leter repetition above 2 - top 10 results
################################################################################
#66 - sequencia bb
#71 - sequencia dd
#100 - sequencia rr
#129 - sequencia pp
#133 - sequencia ff
#238 - sequencia ss
#353 - sequencia tt
#463 - sequencia oo
#549 - sequencia ee
#746 - sequencia ll
################################################################################
# Digraph leter repetition above 40 - top 10 results
################################################################################
#1344 - digraph at
#1349 - digraph re
#1418 - digraph nd
#1494 - digraph it
#1706 - digraph ou
#1783 - digraph an
#2091 - digraph er
#2273 - digraph in
#3824 - digraph th
#3997 - digraph he
################################################################################
# Digraph leter repetition above 40- top 10 results
################################################################################
#462 - trigraph sai
#483 - trigraph aid
#518 - trigraph ice
#541 - trigraph hat
#576 - trigraph you
#582 - trigraph she
#691 - trigraph her
#1026 - trigraph and
#1069 - trigraph ing
#2505 - trigraph the
