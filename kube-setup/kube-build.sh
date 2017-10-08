#
# 编译kube组件的几种方式
#
make kubelet
make all WHAT=cmd/kubelet GOFLAGS=-v
go install k8s.io/kubernetes/cmd/kubelet


# 交叉编译需注意
在Mac上make会出错:因为make会调用一些脚本，而mac环境上没有。
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install ---
