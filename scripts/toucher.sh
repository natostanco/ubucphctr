#!/bin/bash

echo "touching list.txt"
while read in;
do
  echo $in ;
  touch $in ;
done < /host/list.txt
echo "done touching list.txt"

