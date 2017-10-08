package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"

	//"time"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

func main() {
	var kubeconfig *string
	if home := homeDir(); home != "" {
		kubeconfig = flag.String("kubeconfig", filepath.Join(home, ".kube", "config"), "(optional) absolute path to the kubeconfig file")
	} else {
		kubeconfig = flag.String("kubeconfig", "", "absolute path to the kubeconfig file")
	}

	var namespace *string
	namespace = flag.String("namespace", "default", "namespace in which pods exist")
	flag.Parse()

	config, _ := clientcmd.BuildConfigFromFlags("", *kubeconfig)

	clientset, _ := kubernetes.NewForConfig(config)

	podsClient := clientset.Core().Pods(*namespace)

	list, _ := podsClient.List(metav1.ListOptions{})

	fmt.Println("Pods Len: ", len(list.Items))
	for _, i := range list.Items {
		fmt.Println("Pod Name: ", i.Name)
	}
}

func homeDir() string {
	if h := os.Getenv("HOME"); h != "" {
		return h
	}
	return os.Getenv("USERPROFILE") // windows
}
