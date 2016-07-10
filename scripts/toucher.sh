#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
touch `cat /host/list.txt`
sleep 3
touch `cat /host/manuallist.txt`
sleep 3
touch `cat /host/lddlist.txt`
echo "done touching list.txt"

