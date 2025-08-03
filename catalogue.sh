#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SCRIPT_DIR=$PWD

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)"| tee -a $LOG_FILE

# check the user has root previalages or not
if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo "You are running with root access" | tee -a $LOG_FILE
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N"| tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N"| tee -a $LOG_FILE
        exit 1
    fi
}

dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "DISABLING DEFAULT NODEJS"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "ENABLING DEFAULT NODEJS"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "INSTALLING NODEJA SERVICE"

id roboshop
if [ $? -ne 0 ]
then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
    VALIDATE $? "CREATING SYSTEM USER"
else
    echo -e "SYSTEM USER ALREADY CREATED"
fi

mkdir -p /app &>>$LOG_FILE
VALIDATE $? "CREATING APP DIRECTORY"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip  &>>$LOG_FILE
VALIDATE $? "DOWNLOADING CATALOGUE"

cd /app 
unzip /tmp/catalogue.zip &>>$LOG_FILE
VALIDATE $? "UNZIPPING CATALOGUE"

npm install &>>$LOG_FILE
VALIDATE $? "INSTALLING DEPENDENCIES"

cp  $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
VALIDATE $? "COPYING CATALOGUE SERVICE"

systemctl daemon-reload &>>$LOG_FILE
systemctl enable catalogue  &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE

VALIDATE $? "starting catalogue"

cp $SCRIPT_DIR/mongodb.repo /etc/yum.repos.d/mongodb.repo

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "installing mongodb client"

mongosh --host mongodb.tejaswini.site </app/db/master-data.js &>>$LOG_FILE