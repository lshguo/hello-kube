#! /bin/bash

# kube master的service创建

# 需要一个配置，即etcd的ip
ETCD_SERVER="192.168.241.130"
if [ $# -eq 1 ];then
	ETCD_SERVER="$1"
fi

# 依次为master的3个服务
sed "s/ETCD_SERVER/$ETCD_SERVER/g" unit/kube-apiserver.service \
    > /usr/lib/systemd/system/kube-apiserver.service

cp unit/kube-controller-manager.service /usr/lib/systemd/system/kube-controller-manager.service 

cp unit/kube-scheduler.service          /usr/lib/systemd/system/kube-scheduler.service


systemctl daemon-reload
systemctl start kube-apiserver.service
systemctl start kube-controller-manager.service
systemctl start kube-scheduler.service


