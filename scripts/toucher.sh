#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
while read in;
do
  echo $in ;
  touch $in ;
done < /host/list.txt
echo "done touching list.txt"

