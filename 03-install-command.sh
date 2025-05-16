#!/bin/bash

USERID=$(id -u)

if [$USERID -ne 0]
then
    echo "Proceed to install"
else
    echo "Show the error and please install with roort access"
fi