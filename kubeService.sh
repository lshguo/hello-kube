#! /bin/bash

if [ $# -ne 1 ];then
	echo "need 1 argument"
	exit 1
fi

cmd=$1

# kube Master
for i in kube-apiserver.service kube-controller-manager.service kube-scheduler.service
do
	systemctl "$cmd" "$i"
	echo "$i $cmd""ed"
done

# kube Worker
for i in kubelet.service kube-proxy.service
do
	systemctl "$cmd" "$i"
        echo "$i $cmd""ed"
done
