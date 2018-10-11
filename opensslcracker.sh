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
printf "Working..."

while read line
do
openssl aes-256-cbc -d -a -in $1 -pass pass:"$line" -out out.txt 2>out.txt >/dev/null
if file out.txt | grep -q 'out.txt: ASCII text'
	then
		printf "\n==================================================\n\n" && cat out.txt && printf "\n\n==================================================" && printf "\nPassword is $line\n" && exit
	else
		: 
fi
done < ./password.txt
