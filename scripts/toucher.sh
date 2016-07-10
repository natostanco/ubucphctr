#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
i=0
while read in;
do
  touch "$in"
  #if [[ "$(( $i % 25 ))" == "0" ]] ; then
  #  i=$(( $i + 1 ))
    echo $in
  #  sleep 2
  #fi
done < /host/list.txt
echo "done touching list.txt"

