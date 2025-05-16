#!/bin/bash

echo "all variables passed to script $@"
echo "number of variables passed to script $#"
echo "file name of the script $0"
echo "present working directory of the script $PWD"
echo "Home directory of the script, who is running the script $HOME"
echo "Username of the present running script $USER"
echo "PID of the script $$"
echo "PID of last command running in background $!"
sleep 10 &
echo "exit status of the last command executed $?"