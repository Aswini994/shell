#!/bin/bash

#id= userid, groupid will display
#sudo id= user id. group id of root will dispaly
#id -u= only user id will display

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error: Please install with root access"
    exit 1 #give other than zero, upto 127
else
    echo "you are running with root access"
fi

VALIDATE()
{    if [ $? -eq 0]
    then
        echo "Installing mysql is success"
    else
        echo "Installing mysql is failure"
    exit 1
    fi
    }

dnf list installed mysql
if [ $? -ne 0]
then
    echo "mysql is not installed, going to install it"
    dnf install mysql -y
    VALIDATE $? "mysql"
 else
    echo "Already Installing mysql"
 fi

dnf list installed python3
if [ $? -ne 0]
then
    echo "python3 is not installed, going to install it"
    dnf install python3 -y
    VALIDATE $? "python3"
 else
    echo "Already Installing python3"
 fi



dnf list installed nginx
if [ $? -ne 0]
then
    echo "nginx is not installed, going to install it"
    dnf install nginx -y
    VALIDATE $? "nginx"
 else
    echo "Already Installing nginx"

 fi
