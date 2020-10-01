#!/bin/bash

# for blue-green-deployment pipeline

# creating pvc, secrets, configmaps and serviceaccount
kubectl create -f creds/quay-secret.yaml
kubectl create -f creds/serviceaccount.yaml
kubectl create cm tokens-configmap --from-file=misc/tokens.json
kubectl create -f pvcs/shared-workspaces.yaml

# installing tasks from upstream catalog
kubectl create -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-clone/0.2/git-clone.yaml
kubectl create -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/replace-tokens/0.1/replace-tokens.yaml
kubectl create -f https://raw.githubusercontent.com/vinamra28/catalog/vinamra28/sonar-fix/sonarqube/sonarqube.yaml
kubectl create -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/buildah/0.1/buildah.yaml
kubectl create -f tasks/blue-green-deploy.yaml
# installing the pipeline
kubectl create -f pipelines/deployment-pipeline.yaml
