#!/bin/bash
#set -ex

export FILE_NAME=$(cat /etc/machine-id)-$(date +%d-%m-%y)

cmds=( 
"cat /etc/machine-id" 
"hostnamectl"
"kubectl create namespace sock-shop"
"kubectl apply -n sock-shop -f https://github.com/microservices-demo/microservices-demo/blob/master/deploy/kubernetes/complete-demo.yaml?raw=true"
"DEPLOYMENT_COMPLETION"
"kubectl get cs"
"kubectl get pods --all-namespaces"
"kubectl get nodes -o wide"
"kubectl get all -o wide"
"kubectl get ns"
"kubectl cluster-info"
"kubectl get events"
"kubectl describe nodes"
"kubectl describe pods --all-namespaces"
"kubectl cluster-info dump"
"cat  /etc/apt/sources.list"
  )


SCRIPT_DEPLOYMENT()
{

for cmd in  "${cmds[@]}"

do 
	
	printf "Colleting output of command $cmd \n " 
	echo "+++++++++++++++++ $cmd " >> $FILE_NAME
	$cmd >> $FILE_NAME 2>&1
	echo "++++++++++++++++++++++++++++++++++++++++  "  >> $FILE_NAME
	printf "\n\n" >> $FILE_NAME 
done


for kube in $(dpkg -l | grep kube | awk  '{print $2}')
do 
	printf "Colleting output of apt show $kube \n "
	apt show $kube >> $FILE_NAME 2>&1; 
done

printf "Colleting last 300 lines of etcd logs  \n "
echo "+++++++++++++++++ recent etcd logs " >> $FILE_NAME
sudo cat /var/log/containers/etc* | tail -n 300 >>  $FILE_NAME

printf  "\n All done \n\n 
 1) Deployemnt created namespace sock-shop. Feel free to delete if safe. This will also remove all containers and its data \n
 2) Script has captured output of all commands infile called $FILE_NAME in current directory. Please review to ensure that you are happy to share this data \n\n " 

}

DEPLOYMENT_COMPLETION()
{

cont_not_ready=$(kubectl get pods -n sock-shop |  grep -v STATUS | awk '{print $3}' | grep -v Running | wc -l)

while [ $cont_not_ready -gt 0 ]
do
        echo $cont_not_ready " containers are not ready"
        sleep 1
        cont_not_ready=$(kubectl get pods -n sock-shop |  grep -v STATUS | awk '{print $3}' | grep -v Running | wc -l)
done
}


clear

printf " \n This script will: \n
 - create new namespace in your kubernettes cluster called sock-shop and deploy multiple containers to it \n
 - collect various logs and outputs from commands definded in the script \n
 - provide you with a file name at the end of the run for your review \n

 You can review this test sock-shop deployment code at: https://github.com/microservices-demo/microservices-demo \n 
 If you already have namespace called sock-shop or do not want to create it or/and deploy containers to your solution, stop execution of scipt by entering letter N or simply hitting enter. If you are happy for this script to create namespace called sock-shop type in uppercase Y. \n\n "

read -p "Do you wish to continue? " yn
    case $yn in
        [Y]* ) SCRIPT_DEPLOYMENT;;
        [Nn]* ) exit;;
        * ) echo "Please answer Y or N/n.";;
    esac


