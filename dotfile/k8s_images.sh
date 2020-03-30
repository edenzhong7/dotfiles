#!/bin/sh
azk8spull k8s.gcr.io/kube-proxy:v1.15.5
azk8spull k8s.gcr.io/kube-controller-manager:v1.15.5
azk8spull k8s.gcr.io/kube-scheduler:v1.15.5
azk8spull k8s.gcr.io/kube-apiserver:v1.15.5
azk8spull k8s.gcr.io/coredns:1.3.1
azk8spull k8s.gcr.io/pause:3.1
azk8spull k8s.gcr.io/etcd:3.3.10
