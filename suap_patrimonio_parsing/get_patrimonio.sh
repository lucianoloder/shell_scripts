#/bin/bash

# this script fetches the SUAP page concerning the material given by the files[j] files and searches its owner
# It uses wget, grep, and some other nice command-line features.
# Unfortunately it cant make login in the page, so it assumes that the user has done login and saved the cookie as cookies.txt

# this firefox add-on might help:
# https://addons.mozilla.org/en-US/firefox/addon/export-cookies-txt
#
# TODO: We can always do a login using python and selenium webbrowser.
# 		Either we rewrite this code in python or just make a python script
# 		to perform the login and save the cookie, so wget can use it.

# Input File Separator (IFS) is set to newline, to prevent bash escaping spaces in the file names
IFS=$'\n'

# BASH array containing CSV files with only the patrimonio number, one per line.
declare -a files=('lab15.csv' 'lab16.csv' 'lab634.csv' 'lab636.csv' 'lab638-lab.csv' 'lab638-lab.csv' 'lab641.csv' 'coordenadoria.csv');
#declare -a files=('lab15.csv' 'lab16.csv');

# we grep the page concerning the given material and store it temorarily here
temp_file=/tmp/teste.htm
default_owner="Luciano Ludwig Loder"

#Loop at every file in the files variable
for ((j==0; j < ${#files[@]}; j++)) { 

	input_file="original/${files[$j]}"
#	output_file="parsed/`echo ${files[$j]} | cut -d\. -f1`.csv"
	output_file="parsed/${files[$j]}"
	transferencia_output_file="termos_transferencia/${files[$j]}"
	unparsed_output_file="parsed/`echo ${files[$j]} | cut -d\. -f1`_unparsed.csv"
	transferencia_output_file_sorted="termos_transferencia/`echo ${files[$j]} | cut -d\. -f1`_sorted.csv"

	echo " "
	echo "Input and output files: $input_file, $output_file";

	# creates output file header
	echo "responsavel | id | descricao local |descricao SUAP" > $output_file

	# get the cookies, for authentication. 
	# Not working yet, we must login via firefox and save cookies
	#wget --save-cookies cookies.txt --post-data 'id_username=lucianoloder&id_password=lalalalala' http://suap.ifsul.edu.br/accounts/login

	# Loop at every line of the input file
	for i in `cat $input_file`; do
		# Parses ID (first field) and description (second field) from CSV file
		id=`echo $i | cut -d\; -f2`
		desc_local=`echo $i | cut -d\; -f1`

		# regular expression which match with anything that is a number 
		# Needed to test if ID is a number or not (field without patrimonio)
		re='^[0-9]+$'
		if ! [[ $id =~ $re ]] ; then
			echo "skipping $desc_local";
			echo "$id ; $desc_local; " >> $unparsed_output_file
			continue;
		fi

		# for debug
		#echo "i is $i"
		#echo "id is $id"
		#echo "desc_local is $desc_local"
		#echo " "
		#continue;
		
		# get the page we are interested, from SUAP
		wget --load-cookies cookies.txt --output-document=$temp_file -q http://suap.ifsul.edu.br/patrimonio/inventario/$id
		# parses owner and description from SUAP - may differ from local description
		owner="`cat $temp_file | sed -n '/Carga\ Atual/{n;n;n;p}'| sed  's/^[ ]*//g'`"
		desc="`cat $temp_file | sed -n '/Descri/{n;p}' | sed 's/<td><span id=\"inventario_descricao\">//g' | sed 's/<\/span><\/td>//g'`"
		echo "$owner ; $id ; $desc_local ; $desc" >> $output_file

		# Old code: extracts only the owner, and not description, from SUAP
		#wget --load-cookies cookies.txt --output-document=- -q http://suap.ifsul.edu.br/patrimonio/inventario/$i | sed -n '/Carga\ Atual/{n;n;n;p}'

		# if owner is not the default owner, create the "transferencia de bem patrimonial"
		if [ -z "`echo $owner | grep $default_owner`" ];  then
			echo "$owner; $id ; $desc_local; $desc; " >> $transferencia_output_file
		fi
		
		#sort transferencia_file
		cat $transferencia_output_file | sort > $transferencia_output_file_sorted

	done;
}

