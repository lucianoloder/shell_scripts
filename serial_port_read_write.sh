#!/bin/bash

# Reads data from a file, in ${input_file}, sends it to an arduino
# connected in a serial port at ${serial_port} and saves the response
# in ${output_file}
#
# Useful to automate communication with an arduino plugged into the
# serial-to-usb port

# documentation:
# http://ftp.monash.edu.au/pub/linux/docs/HOWTO/Serial-HOWTO-4.html
# https://www.linusakesson.net/programming/tty/

input_data=12345678

input_file=keys_messages_ciphers.txt
output_file=ciphertexts.txt
serial_port=/dev/ttyACM0

# configure the serial port - can set the baud rate and many more params
sudo stty -F ${serial_port} icanon 

for i in $(cat ${input_file}); do
	# the input file data is formatted in the following string:
	# k_f49d7b07c3ee29ef_m_087278270f92d091_c_aedb11e61745fcb3
	# parsing only the plaintext and ciphertext
	plaintext=$(echo $i | cut -d_ -f4)
	ciphertext=$(echo $i | cut -d_ -f6)

	echo "Message ${plaintext}, cipher=${ciphertext}" >> ${output_file}

	# sends the data to the device
	echo ${plaintext} > ${serial_port}

	#Receives the response
	head ${serial_port} -n 2 >> ${output_file}

	echo " " >> ${output_file}
done

