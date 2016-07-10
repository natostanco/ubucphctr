#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
i=0
while read in;
do
  i=$(( $i + 1 ))
  touch "$in"
  if [[ "$(( $i % 25 ))" == "0" ]] ; then
    echo $in
    sleep 0.3
  fi
done < /host/list.txt
echo "done touching list.txt"

