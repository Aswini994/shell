#!/bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error: Please install with root access"
    exit 1 #give other than zero, upto 127
else
    echo "you are running with root access"
fi

VALIDATE()
{
    if [ $1 -eq 0 ]
    then
        echo "Installing $2 is success"
    else
        echo "Installing $2 is failure"
    exit 1
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
 echo "mysql is not installed, going to install it"
 dnf install mysql -y
 VALIDATE $? "MYSQL"
 else
    echo "Already Installing mysql"
 fi

 dnf list installed python3
if [ $? -ne 0 ]
then
 echo "python3 is not installed, going to install it"
 dnf install python3 -y
 VALIDATE $? "PYTHON3"
 else
    echo "Already Installing python3"
 fi

dnf list installed nginx
if [ $? -ne 0 ]
then
 echo "nginx is not installed, going to install it"
 dnf install nginx -y
 VALIDATE $? "NGINX"
 else
    echo "Already Installing nginx"

 fi