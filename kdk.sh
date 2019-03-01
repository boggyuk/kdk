#!/bin/bash

export FILE_NAME=$(cat /etc/machine-id)


echo "+++++++++++++++++ machine-id" >> $FILE_NAME
cat /etc/machine-id >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ hostname" >> $FILE_NAME
hostnamectl >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ kubectl get cs" >> $FILE_NAME
kubectl get cs >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ kubectl get nodes -o wide" >> $FILE_NAME
kubectl get nodes -o wide >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ kubectl get all -o wide" >> $FILE_NAME
kubectl get all -o wide >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ kubectl get ns" >> $FILE_NAME
kubectl get ns >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ kubectl cluster-info" >> $FILE_NAME
kubectl cluster-info >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ kubectl get events" >> $FILE_NAME
kubectl get events >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ dpkg -l | grep kube" >> $FILE_NAME
for i in $(dpkg -l | grep kube | awk  '{print $2}'); do apt show $i; done >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ apt/sources.list " >> $FILE_NAME
cat  /etc/apt/sources.list | grep -v '#' >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++  kubectl describe nodes" >> $FILE_NAME
kubectl describe nodes  >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++  kubectl describe pods --all-namespaces " >> $FILE_NAME
kubectl describe pods --all-namespaces  >> $FILE_NAME

echo "+++++++++++++++++" >> $FILE_NAME
echo "+++++++++++++++++ kubectl cluster-info dump" >> $FILE_NAME
kubectl cluster-info dump >> $FILE_NAME




#!/bin/bash
  
export FILE_NAME=$(cat /etc/machine-id)

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
  echo "+++++++++++++++++ $($i) " >> $FILE_NAME
  $i >> $FILE_NAME
  echo "++++++++++++++++++++++++++++++++++++++++  " >> $FILE_NAME
  printf "\n"
done



for i in $(dpkg -l | grep kube | awk  '{print $2}'); do apt show $i; done
cat  /etc/apt/sources.list | grep -v '#'











