#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-script-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1
)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" &>> $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R Error: Please install with root access$N" &>> $LOG_FILE
    exit 1 #give other than zero, upto 127
else
    echo "you are running with root access"
fi

VALIDATE()
{
    if [ $1 -eq 0 ]
    then
        echo -e "Installing $2 is $G success$N" &>> $LOG_FILE
    else
        echo -e "Installing $2 is $R failure$N" &>> $LOG_FILE
    exit 1
    fi
}

dnf list installed mysql &>> $LOG_FILE
if [ $? -ne 0 ]
then
 echo "mysql is not installed, going to install it"
 dnf install mysql -y &>> $LOG_FILE
 VALIDATE $? "MYSQL"
 else
    echo -e "Nothing to do $Y Already Installing mysql$N" &>> $LOG_FILE
 fi

 dnf list installed python3 &>> $LOG_FILE
if [ $? -ne 0 ]
then
 echo "python3 is not installed, going to install it"
 dnf install python3 -y &>> $LOG_FILE
 VALIDATE $? "PYTHON3"
 else
    echo -e "Nothing to do $Y Already Installing python3$N" &>> $LOG_FILE
 fi

dnf list installed nginx &>> $LOG_FILE
if [ $? -ne 0 ]
then
 echo "nginx is not installed, going to install it"
 dnf install nginx -y &>> $LOG_FILE
 VALIDATE $? "NGINX"
 else
    echo -e "Nothing to do $Y Already Installing nginx$N" &>> $LOG_FILE

 fi