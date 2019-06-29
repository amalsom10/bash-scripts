#!/bin/bash
echo -e "script will replace the quota values in package of a particular cpanel user\n"
echo e "enter the cpanel user name"
read user
for i in `sudo ls -la /var/cpanel/packages/ | grep $user | awk '{print $9}'` 
do 
echo -e "enter the new quota value for $i"
read quota
sudo sed -i "s/QUOTA=.*/QUOTA=$quota/g" /var/cpanel/packages/$i
done
