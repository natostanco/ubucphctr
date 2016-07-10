#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
i=0
while read in;
do
  sleep 0.01
  touch "$in"
  sleep 0.01
done < /host/list.txt
echo "done touching list.txt"

