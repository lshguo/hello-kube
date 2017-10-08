#! /bin/bash

# kube worker的service创建

# 需要2个配置
API_SERVER="192.168.241.130"
HOSTNAME="192.168.241.130"
if [ $# -eq 2 ];then
	API_SERVER="$1"
        HOSTNAME="$2"
fi

# 依次为worker的2个服务
sed "s/API_SERVER/$API_SERVER/g" unit/kubelet.service \
    | sed "s/HOSTNAME/$HOSTNAME/g" \
      > /usr/lib/systemd/system/kubelet.service

sed "s/API_SERVER/$API_SERVER/g" unit/kube-proxy.service \
    > /usr/lib/systemd/system/kube-proxy.service


systemctl daemon-reload
systemctl start kubelet.service
systemctl start kube-proxy.service


