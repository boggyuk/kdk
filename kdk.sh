#!/bin/bash

export FILE_NAME=$(cat /etc/machine-id)-$(date +%d-%m-%y)

cmds=( 
"cat /etc/machine-id" 
"hostnamectl"
"kubectl get cs"
"kubectl get nodes -o wide"
"kubectl get all -o wide"
"kubectl get ns"
"kubectl cluster-info"
"kubectl get events"
"kubectl describe nodes"
"kubectl describe pods --all-namespaces"
"kubectl cluster-info dump"

  )



for i in  "${cmds[@]}"

do 
	echo "+++++++++++++++++ $i " >> $FILE_NAME
	$i >> $FILE_NAME
	echo "++++++++++++++++++++++++++++++++++++++++  " >> $FILE_NAME
	printf "\n\n" >> $FILE_NAME 
done


for i in $(dpkg -l | grep kube | awk  '{print $2}')
do 
	apt show $i >> $FILE_NAME; 
done

echo "+++++++++++++++++ apt/source.list " >> $FILE_NAME
cat  /etc/apt/sources.list | grep -v '#'  >>  $FILE_NAME
