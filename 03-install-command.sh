#!/bin/bash

#id= userid, groupid will display
#sudo id= user id. group id of root will dispaly
#id -u= only user id will display

USERID=$(id -u)

#userid=0 for sudo access

if [ $USERID -ne 0 ]
then
    echo "Error: Please install with root access"
    exit 1 #give other than zero, upto 127
else
    echo "you are running with root access"
fi

dnf install mysql -y

if [ $? -eq 0 ]
then
 echo "Installing mysql is success"
 else
 echo "Installing mysql is failure"
 exit 1
 
 fi
