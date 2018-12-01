#!/bin/bash
cat << "EOF"
   ____                    _____ _____ _      
  / __ \                  / ____/ ____| |     
 | |  | |_ __   ___ _ __ | (___| (___ | |     
 | |  | | '_ \ / _ \ '_ \ \___ \\___ \| |     
 | |__| | |_) |  __/ | | |____) |___) | |____ 
  \____/| .__/ \___|_| |_|_____/_____/|______|
  / ____| |            | |                    
 | |    |_|__ __ _  ___| | _____ _ __         
 | |    | '__/ _` |/ __| |/ / _ \ '__|        
 | |____| | | (_| | (__|   <  __/ |           
  \_____|_|  \__,_|\___|_|\_\___|_|           

By: Raphaeangelo
EOF
if [[ $# -eq 0 ]] ; then
	echo 'You need to supply the location of the encrypted file AND the location of the password file in the arguments. E.g. ./opensslcracker.sh PATH/TO/THE/FILE.txt.enc PATH/TO/THE/PASSWORD.txt '
	exit 0
fi
	if [[ $# > 2 ]] ; then
	echo 'You have too many arguments. Supply the encrypted file and the password file only. E.g. ./opensslcracker.sh PATH/TO/THE/FILE.txt.enc PATH/TO/THE/PASSWORD.txt'
	exit 0
fi
	if [[ $2 == '' ]] ; then
	echo 'You need to supply a password (wordlist) file'
	exit 0
fi
if file $2 | grep -q ": UTF-8 Unicode text" ; then
        :
else
        echo "The password file is not a valid text document"
        exit 0
fi
file=$(echo "$1" | cut -f 1 -d '.')
if file $1 | grep -q "openssl enc'd data with salted password, base64 encoded" ; then
	COUNTER=0
	start_time="$(date -u +%s)"
	while read line
	do
	COUNTER=$[COUNTER + 1]
	echo -ne "\\033[KPassword count [$COUNTER] Trying password [$line]\\r"
	if openssl aes-256-cbc -d -a -in $1 -pass pass:"$line" -out $file.decrypted.txt 2>$file.decrypted.txt >/dev/null && file $file.decrypted.txt | grep -q ": ASCII text" ; then
	        echo "=================================================="
	        echo ""
	        cat $file.decrypted.txt
	        echo ""
	        echo "=================================================="
	        echo "The password is $line"
	        end_time="$(date -u +%s)"
	        elapsed="$(($end_time-$start_time))"
	        echo "Time took $elapsed seconds and $COUNTER passwords tried"
	        exit
	elif openssl aes-256-cbc -d -a -in $1 -pass pass:"$line" -out $file.decrypted.txt -md md5 2>$file.decrypted.txt >/dev/null && file $file.decrypted.txt | grep -q ": ASCII text" ; then
		echo "=================================================="
		echo ""
		cat $file.decrypted.txt
		echo ""
		echo "=================================================="
		echo "The password is $line"
		end_time="$(date -u +%s)"
		elapsed="$(($end_time-$start_time))"
		echo "Time took $elapsed seconds and $COUNTER passwords tried"
		exit
	elif openssl aes-256-cbc -d -a -in $1 -pass pass:"$line" -out $file.decrypted.txt -md sha256 2>$file.decrypted.txt >/dev/null && file $file.decrypted.txt | grep -q ": ASCII text" ; then
	        echo "=================================================="
	        echo ""
	        cat $file.decrypted.txt
	        echo ""
	        echo "=================================================="
	        echo "The password is $line"
	        end_time="$(date -u +%s)"
	        elapsed="$(($end_time-$start_time))"
	        echo "Time took $elapsed seconds and $COUNTER passwords tried"
	        exit
	else
		:
	fi
	done < $2
fi
if file $1 | grep -q "openssl enc'd data with salted password" ; then
	COUNTER=0
	start_time="$(date -u +%s)"
	while read line
	do
	COUNTER=$[COUNTER + 1]
	echo -ne "\\033[KPassword count [$COUNTER] Trying password [$line]\\r"
	if openssl aes-256-cbc -d -in $1 -pass pass:"$line" -out $file.decrypted.txt 2>$file.decrypted.txt >/dev/null && file $file.decrypted.txt | grep -q ": ASCII text" ; then
	        echo "=================================================="
	        echo ""
	        cat $file.decrypted.txt
	        echo ""
	        echo "=================================================="
	        echo "The password is $line"
	        end_time="$(date -u +%s)"
	        elapsed="$(($end_time-$start_time))"
	        echo "Time took $elapsed seconds and $COUNTER passwords tried"
	        exit
	elif openssl aes-256-cbc -d -in $1 -pass pass:"$line" -out $file.decrypted.txt -md md5 2>$file.decrypted.txt >/dev/null && file $file.decrypted.txt | grep -q ": ASCII text" ; then
		echo "=================================================="
		echo ""
		cat $file.decrypted.txt
		echo ""
		echo "=================================================="
		echo "The password is $line"
		end_time="$(date -u +%s)"
		elapsed="$(($end_time-$start_time))"
		echo "Time took $elapsed seconds and $COUNTER passwords tried"
		exit
	elif openssl aes-256-cbc -d -in $1 -pass pass:"$line" -out $file.decrypted.txt -md sha256 2>$file.decrypted.txt >/dev/null && file $file.decrypted.txt | grep -q ": ASCII text" ; then
	        echo "=================================================="
	        echo ""
	        cat $file.decrypted.txt
	        echo ""
	        echo "=================================================="
	        echo "The password is $line"
	        end_time="$(date -u +%s)"
	        elapsed="$(($end_time-$start_time))"
	        echo "Time took $elapsed seconds and $COUNTER passwords tried"
	        exit
	else
	:
	fi
	done < $2
else
	echo "This file doesn't appear to be encrypted using openssl AES-256"
	exit 0
fi
