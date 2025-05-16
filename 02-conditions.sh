#!/bin/bash

NUMBER=$1

# -gt greater than
# -lt less than
# -eq equals to
# -ne not euals to

if [ $NUMBER -lt 10 ]
then 
    echo "$NUMBER less than 10"
else
    echo "$NUMBER IS NOT LESS THAN 10"
fi