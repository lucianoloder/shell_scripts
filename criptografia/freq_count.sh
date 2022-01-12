#!/bin/bash

# \brief This code implements a letter frequency analysis using command-line tools
# \params $1 file to be analyzed

########################################
# input parsing
########################################
if [ -z "$1" ] ; then
	echo " usage: $0 <filename> <top letters - optional>"
	exit 0
fi

#FILE_NAME="alice-in-wonderland.txt"
FILE_NAME=$1
TOP_RESULTS=$2

echo "########################################"
echo " Letter frequency, in percent, in ${FILE_NAME}"
echo "########################################"

TOTAL_LETTERS="$(wc -c ${FILE_NAME} | cut -d\  -f1)"
echo "total number of chars: ${TOTAL_LETTERS}"
echo ''

TOTAL=''

for i in {a..z} ; do
#	echo -n "letra $i: ";

	# first 'tr' puts all text in lowercase, second one removes all characters, leaving only '$i', and 'wc' counts it.
	letter_count=$(cat ${FILE_NAME} | tr [:upper:] [:lower:]  | tr -cd $i | wc -c)
	# Adds the letter count and its frequency, in percentage, to the total
	#TOTAL="${TOTAL}"$'\n'"# $(LC_NUMERIC="en_US.UTF-8" printf " %07.4f"  $(echo "scale=4; 100 * ${letter_count} / ${TOTAL_LETTERS} " | bc ) ) % - ${letter_count} - letter $i";
	# adds only the letter frequency, in percentage
	TOTAL="${TOTAL}"$'\n'"# $(LC_NUMERIC="en_US.UTF-8" printf " %07.4f" $(echo "scale=4; 100 * ${letter_count} / ${TOTAL_LETTERS} " | bc ) ) % - letter $i";
done;

if [ -n "${TOP_RESULTS}" ]; then
	echo "$TOTAL" | sort -h | tail -n ${TOP_RESULTS}
else
	echo "$TOTAL" | sort -h 
fi

# Output example, for an english plaintext

########################################
# Letter frequency, in percent, in alice-in-wonderland.txt
########################################
#total number of chars: 167546


#  00.0477 % - 80 - letter z
#  00.1050 % - 176 - letter x
#  00.1313 % - 220 - letter q
#  00.1402 % - 235 - letter j
#  00.5747 % - 963 - letter v
#  00.7699 % - 1290 - letter k
#  01.0421 % - 1746 - letter b
#  01.1746 % - 1968 - letter p
#  01.4216 % - 2382 - letter f
#  01.4724 % - 2467 - letter m
#  01.5422 % - 2584 - letter y
#  01.7571 % - 2944 - letter g
#  01.7619 % - 2952 - letter w
#  01.7929 % - 3004 - letter c
#  02.3742 % - 3978 - letter u
#  03.1101 % - 5211 - letter l
#  03.2647 % - 5470 - letter d
#  03.9463 % - 6612 - letter r
#  04.3391 % - 7270 - letter s
#  04.7091 % - 7890 - letter h
#  04.8064 % - 8053 - letter n
#  05.1544 % - 8636 - letter i
#  05.6569 % - 9478 - letter o
#  05.8521 % - 9805 - letter a
#  07.2827 % - 12202 - letter t
#  09.1903 % - 15398 - letter e

########################################
# Letter frequency, in percent, in alice-in-wonderland.txt
########################################
#total number of chars: 167546


#  00.0477 % - letter z
#  00.1050 % - letter x
#  00.1313 % - letter q
#  00.1402 % - letter j
#  00.5747 % - letter v
#  00.7699 % - letter k
#  01.0421 % - letter b
#  01.1746 % - letter p
#  01.4216 % - letter f
#  01.4724 % - letter m
#  01.5422 % - letter y
#  01.7571 % - letter g
#  01.7619 % - letter w
#  01.7929 % - letter c
#  02.3742 % - letter u
#  03.1101 % - letter l
#  03.2647 % - letter d
#  03.9463 % - letter r
#  04.3391 % - letter s
#  04.7091 % - letter h
#  04.8064 % - letter n
#  05.1544 % - letter i
#  05.6569 % - letter o
#  05.8521 % - letter a
#  07.2827 % - letter t
#  09.1903 % - letter e

