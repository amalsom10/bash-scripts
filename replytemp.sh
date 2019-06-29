#!/bin/bash
echo "$(tput setaf 2) This script is very sensitive handle with care $(tput sgr 0)"
echo -e "\n$(tput setaf 1)This script is to generate template reply after migration $(tput sgr 0) \n "
read -n 1 -s -r -p "Press any key to continue generation"
echo -e "OK master !!!!!!!!!!!!!!!!  Need few details \n"
echo -e "$(tput setaf 2) Enter the domain $(tput sgr 0)\n"
read domain
touch reply 
echo -e "$(tput setaf 1) Gathering details... $(tput sgr 0)"
hos=$(echo `hostname`)
read -p "1.WHM & 2.cPanel   " opt
if (("$opt" == 1 )) ; 
then 
port=2086
else 
port=2082
fi 
user=$(sudo grep -w $domain /etc/trueuserdomains | awk -F ' ' '{print $2}')
echo -e "$(tput setaf 2) \n Enter user password : $(tput sgr 0)"
read pass
ip=$(sudo grep  -1 $domain /usr/local/apache/conf/httpd.conf | grep "VirtualHost" | grep ":443" | awk -F ' ' '{print $2}' | awk -F ':' '{print $1}' | sort | uniq)
nameser=$(grep -i NS /etc/wwwacct.conf | grep -w "ns1" | awk -F ' ' '{print $2}' | cut -d '.' -f2,3-)

echo -e "\n"
echo "$(tput setaf 2)DETAILS BEFORE PROCEEDING WITH REPLY CREATION  $(tput sgr 0)"

echo -e "$(tput setaf 2)Domain Name      :\t $domain  $(tput sgr 0)"
echo -e "$(tput setaf 2)Hostname         :\t $hos  $(tput sgr 0)"
echo -e "$(tput setaf 2)Port number      :\t $port  $(tput sgr 0)"
echo -e "$(tput setaf 2)Username         :\t $user  $(tput sgr 0)"
echo -e "$(tput setaf 2)Password         :\t $pass  $(tput sgr 0)"
echo -e "$(tput setaf 2)IP Address       :\t $ip  $(tput sgr 0)"
echo -e "$(tput setaf 2)Nameserver       :\t ns1.$nameser & ns2.$nameser  $(tput sgr 0)"
echo -e "\n"
echo -e "\n"
read -n 1 -s -r -p "Press any key to continue generation"
echo -e "\n"
echo -e "$(tput setaf 1)\nHere is your reply Master....! $(tput sgr 0)"
echo -e "\n"
echo -e "\n"
echo -e "$(tput setaf 2)Hello, \n\nI have completed the migration of your domains.You can use the below details for your new WHM:\n==="
echo -e "URL: http://$hos:$port"
echo -e "Username:$user"
echo -e "Password:$pass"
echo -e "IP Address:$ip\n==="
#echo -e "\n"
echo -e "Before making changes in DNS records, you can check whether the website is working properly on the new server by modifying the hosts file. For eg, to check the working of the domain $domain, do add the below entries in your local machine.\n========"
echo -e "$ip \t $domain \t www.$domain \n======="
#echo -e "\n"
echo -e "This modification will cause the domain to resolve to the new server (i.e, $ip) when accessed from your local machine. You can access the website from your browser and make sure that it is working properly.Similarly, you need to check the working of other domains by replacing the domain name in the above entry.You can refer below KB link to make the exact changes.\n===========\nhttp://manage.resellerclub.com/kb/answer/1806\n==========="
#echo -e "\n"
echo -e "The next step is to resolve the domains to the new server. You can update the name-servers of the domain to ns1.$nameser and ns2.$nameser . Also, note that it takes 24-48 hours for the nameservers to take effect after it is added or modified as it takes this much time for DNS propagation and you may have issues with the website during this period.\n\nAppreciate your patience and cooperation all this while. \n\nDo let us know if you have any queries.$(tput sgr 0)\n"
