# OpenSSLCracker
Simple bash script to brute force OpennSSL AES-256-cbc files.

OpenSSL decrypt will output an error if the password entered was wrong. Because of this I built a script that will brute force the decrypt with passwords from a passwords list. If the password is wrong then the script will ignore it and move on to try another one. The only issues is OpenSSL decrypt doesn't always output errors on a wrong password. This is because AES/CBC can only determine if "decryption works" based on getting the padding right. If the file decrypts but is not recovered (doesn't make sense), then press enter to continue to the next password.
Note: This script is NOT just going through every password in the password.txt only the passwords that didn't result in an error.

Download both the script and the password.txt in the same directory. Feel free to replace "password.txt" with "rockyou.txt" or any other password list you like.

Examples

```./opensslcracker.sh FILE.txt.enc```
