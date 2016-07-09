#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
i=0
while read in;
do
  touch "$in"
  if [[ "$(( $i % 1000 ))" == "0" ]] ; then
    echo $in
    sleep 2
  fi
done < /host/list.txt
echo "done touching list.txt"

