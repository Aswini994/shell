#!/bin/bash

#id= userid, groupid will display
#sudo id= user id. group id of root will dispaly
#id -u= only user id will display

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "please install with roort access"
else
    echo "Don't proceed to install and install with root access"
fi

dnf install mysql -y