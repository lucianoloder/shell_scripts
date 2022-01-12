#!/bin/bash

# Script to convert CSV files into matlab-specific MAT files
# It reads all CSV data found in a folder, called $INCOMING_FOLDER
# and saves it into $OUTCOMING_FOLDER in a MAT file form

# This is not very fast, since it calls matlab from command-line for
# each trace, but works.
#
# There is another script that does the same, but calling BASH from
# inside MATLAB, and is faster.

INCOMING_FOLDER='traces_test',

#OUTCOMING_FOLDER='2019-03-1ktraces_mat'
OUTCOMING_FOLDER="$(date +%Y-%b-%d)_traces_mat"

TEMPFILE=temp.csv

if [ ! -d ${OUTCOMING_FOLDER} ]; then
	echo "Folder ${OUTCOMING_FOLDER} not found, creating it"
	mkdir ${OUTCOMING_FOLDER}
fi

for i in $(ls ${INCOMING_FOLDER}) ; do
	# remove, a partir do fim, a parcela CSV do arquivo
	TRACE_NAME=${i%.csv}
	OUTPUT_NAME=${TRACE_NAME}.mat
	
	echo $i;
	 # tail removes the header
	 # sed removes: 
	 # 	- newlines 
	 # 	- an hyphen at the end of the file.
	 # 	- the CURVE parameter
	 # -e 's/:CURVE //g' 
	tail -n 1 ${INCOMING_FOLDER}/$i | sed -e 's/\n//g' -e 's/-$//g' -e 's/^:.*CURVE //g' > ${TEMPFILE}
	# calls matlab to transform it as a .mat file
	# matlab -nodisplay -nosplash -nodesktop -r " '${TRACE_NAME}'=csvread('${TEMPFILE}'); save('${OUTCOMING_FOLDER}/${OUTPUT_NAME}', '${TRACE_NAME}');quit;"
	matlab -nodisplay -nosplash -nodesktop -r " trace=csvread('${TEMPFILE}'); save('${OUTCOMING_FOLDER}/${OUTPUT_NAME}', 'trace');quit;"

	# to read, use:
	# a=load($i); a.trace;

	rm ${TEMPFILE}

	# matlab script
#	${TRACE_NAME}=csvread('${TEMPFILE}');
#	save(${OUTCOMING_FOLDER}/${OUTPUT_NAME}, ${TRACE_NAME});
done;

# to run BASH in matlab:
#[status,result]=system('tail -n 1 traces_non_null/trace_DES__k=f49d7b07c3ee29ef_m=01c02e73e3f6891d_c=0d1f0a0b6133f585.csv | sed -e "s/:CURVE //g"');
