#!/bin/bash

echo "touching list.txt"
echo "end is `cat /host/list.txt | tail -n 1`" 
touch `cat /host/list.txt`
echo `cat /host/list.txt | grep ceph`
echo `cat /host/list.txt | wc -l`
sleep 3
touch `cat /host/manuallist.txt`
echo `cat /host/manuallist.txt | grep ceph`
echo `cat /host/manuallist.txt | wc -l`
sleep 3
touch `cat /host/lddlist.txt`
echo `cat /host/lddlist.txt | wc -l`
echo "done touching list.txt"

