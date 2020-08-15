#!/bin/bash

# for blue-green-deployment pipeline

# creating pvc, secrets, configmaps and serviceaccount
kubectl create -f creds/quay-secret.yaml
kubectl create -f creds/serviceaccount.yaml
kubectl create cm tokens-configmap --from-file=misc/tokens.json
kubectl create -f pvcs/shared-workspaces.yaml

# installing tasks from upstream catalog
kubectl create -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/git/git-clone.yaml
kubectl create -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/replace-tokens/replace-tokens.yaml
kubectl create -f https://raw.githubusercontent.com/vinamra28/catalog/vinamra28/sonar-fix/sonarqube/sonarqube.yaml
kubectl create -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/buildah/buildah.yaml
kubectl create -f tasks/blue-green-deploy.yaml
# installing the pipeline
kubectl create -f pipelines/deployment-pipeline.yaml
