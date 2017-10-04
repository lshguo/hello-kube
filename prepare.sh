#! /bin/bash

# docker

# etcd

# flannel

# log directory
for i in kube-apiserver  kube-controller-manager  kubelet  kube-proxy  kube-schedule
do
	mkdir -p /root/kubernetes/log/"$i"
done
