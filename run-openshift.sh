#!/bin/bash

# for openshift-install
# 1. mount aws credentials secrets and openshift-install pull-secret and public ssh key
kubectl create -f creds/aws-credentials.yaml
kubectl create -f creds/openshift-install.yaml
# 2.create the pvc which will contain the cluster artifacts after the cluster is provisioned so that it can be used later
kubectl create -f pvcs/openshift-install-pvc.yaml
# 3. install the task from the upstream catalog
kubectl create -f tasks/openshift-install.yaml
# kubectl create -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/openshift-provision/openshift-cluster-create.yaml
# .4 create and start the pipelinerun to provision the cluster on aws
kubectl create -f pipelines/provision-cluster-pipeline.yaml