#!/bin/bash
cat << "EOF" 
   ____                    _____  _____ _       _____                _             
  / __ \                  / ____|/ ____| |     / ____|              | |            
 | |  | |_ __   ___ _ __ | (___ | (___ | |    | |     _ __ __ _  ___| | _____ _ __ 
 | |  | |  _ \ / _ \  _ \ \___ \ \___ \| |    | |    |  __/ _  |/ __| |/ / _ \  __|
 | |__| | |_) |  __/ | | |____) |____) | |____| |____| | | (_| | (__|   <  __/ |   
  \____/| .__/ \___|_| |_|_____/|_____/|______|\_____|_|  \__,_|\___|_|\_\___|_|   
        | |                                                                        
        |_|                                                                        

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

while read line
do
echo -ne "Trying password [$line]                                           \\r" && openssl aes-256-cbc -d -a -in $1 -pass pass:"$line" -out out.txt 2>out.txt >/dev/null
if file out.txt | grep -q 'out.txt: ASCII text'
	then
		printf "\n==================================================\n\n" && cat out.txt && printf "\n\n==================================================" && printf "\nThe password is $line\n" && exit
	else
		: 
fi
done < $2
