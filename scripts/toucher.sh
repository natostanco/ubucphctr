#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
i=0
while read in;
do
  touch "$in"
  if [[ "$(( $i % 500 ))" == "0" ]] ; then
    echo $in
    sleep 1
    i+=1
  fi
done < /host/list.txt
echo "done touching list.txt"

