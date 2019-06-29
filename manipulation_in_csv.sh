#!/bin/bash
echo "$(tput setaf 2) This script is very sensitive handle with care $(tput sgr 0)"
echo -e "\n$(tput setaf 1)This script is to generate csv file in RH Migration $(tput sgr 0) \n "
read -n 1 -s -r -p "Press any key to continue generation"
echo -e "okay master !!!!!!!!!!!!!!!!  creating text file \n"
touch testcsv.txt
echo -e "$(tput setaf 2) File created $(tput setaf 1) Copy csv from WHM to test file $(tput sgr 0)"
echo -e "Copy paste the content here and use ctrl+D to exist \n"
cat > testcsv.txt
echo -e "$(tput setaf 2) Starting processing file... Please hold on $(tput sgr 0) \n"

cat testcsv.txt  | sed -e '1d' | sort -k8 -n -t, | awk -F , '{ if ($8 > 3000)  print $0 > "test1" ; else print $0 > "test2"}'
if [[ -s "test1" ]]
then
echo -e  "$(tput setaf 1)Found large size accounts.... Details copied to test1 $(tput sgr 0) \n"
else
echo -e "$(tput setaf 1) No large accounts found $(tput sgr 0) \n"
fi
echo "----------------------------------------------"
echo " * * * * * * * Main Menu * * * * * * * * * * "
echo "----------------------------------------------"
echo -e "1. Continue migation of small accounts\n"
echo -e "2. Continue migration of large accounts\n"
echo -e "3. Quit\n"
echo "----------------------------------------------"
echo -n -e "$(tput setaf 2) Enter your option [1-3] $(tput sgr 0) \n"
read opt
case $opt in
     1) echo -e "Smaller Accounts\n"
        echo -e "Enter port value \n"
        read ports
        echo -e "Enter password \n"
        read passwds
        echo -e "Enter plan type \n"
        read plans
        echo -e "$(tput setaf 2) Data Input completed... Generating file please hold on $(tput sgr 0) \n"
       cat test2 | awk -F "," '{print $2,$3,$10,$11}' | awk -v a="$ports" -v b="$passwds" -v c="$plans" '{print $1,a,$2,b,$3,$4,c}' | sed 's/ /,/g' > createsmall.txt
       echo -e "\n"
        echo -e "$(tput setaf 1)Done Master... Please check file $(tput sgr 0)  \n"
        ;;
      2) echo -e "Larger Accounts \n"
         echo -e "Enter port value \n"
        read ports
        echo -e "Enter password \n"
        read passwds
        echo -e "Enter plan type \n"
        read plans
        echo -e "$(tput setaf 2) Data Input completed... Generating file please hold on $(tput sgr 0) \n"
       cat test1 | awk -F "," '{print $2,$3,$10,$11}' | awk -v a="$ports" -v b="$passwds" -v c="$plans" '{print $1,a,$2,b,$3,$4,c}' | sed 's/ /,/g' > createlarge.txt
       echo -e "\n"
        echo -e "$(tput setaf 1)Done Master... Please check file $(tput sgr 0)  \n"
         ;;
       3) echo -e "Bye Master\n"
          exit 0
         ;;
esac

