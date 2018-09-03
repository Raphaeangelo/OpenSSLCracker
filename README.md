# OpenSSLCracker
Simple bash script to brute force OpennSSL files.

OpenSSLCracker dycrypts files using a password list. If the password is wrong OpenSSL outputs an error. If the password is wrong (results in an error) then it will disregard the decrypt and move on to the next. The only issues is OpenSSL decrypt doesn't always output errors even if the password is wrong. This is because AES/CBC can only determine if "decryption works" based on getting the padding right. If the file decrypts but is not recovered (doesn't make sense), then press enter to continue to the next password.
Note: This script is NOT just going through every password in the password.txt only the passwords that didn't result in an error.

Download both the script and the password.txt in the same directory. Feel free to replace "password.txt" with "rockyou.txt" or any other password list you like.

Examples

```./opensslcracker.sh FILE.txt.enc```
