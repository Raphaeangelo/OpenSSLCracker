# OpenSSLCracker
Simple bash script to brute force OpennSSL files

OpenSSL decrypt doesnt always output errors when the password was entered incorectly because AES/CBC can only determine if "decryption works" based on getting the padding right. If the file decrypts but is not recovered (doesnt make sense), then press enter to contine.
Note that you are not just going through every password in the password.txt only the passwords that didnt result in an error.

Download both the script and the password.txt in the same directory. Feel free to replace "password.txt" with rockyou.txt or any other password list you like.

Examples

```./opensslcracker.sh FILE.txt.enc```
