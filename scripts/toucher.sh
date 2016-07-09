#!/bin/bash

echo "touching list.txt"
while read in;
do
  touch "$in" &>/dev/null
done < /host/list.txt
echo "done touching list.txt"

