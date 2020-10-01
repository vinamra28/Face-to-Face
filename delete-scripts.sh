# for openshift-install
# 1. mount aws credentials secrets and openshift-install pull-secret and public ssh key
kubectl delete -f creds/aws-credentials.yaml
kubectl delete -f creds/openshift-install.yaml
# 2.delete the pvc which will contain the cluster artifacts after the cluster is provisioned so that it can be used later
kubectl delete -f pvcs/openshift-install-pvc.yaml
# 3. install the task from the upstream catalog
kubectl delete -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/openshift-install/0.1/openshift-install.yaml
# .4 delete and start the pipelinerun to provision the cluster on aws
kubectl delete -f pipelines/provision-cluster-pipeline.yaml

# for blue-green-deployment pipeline

# creating pvc, secrets, configmaps and serviceaccount
kubectl delete -f creds/quay-secret.yaml
kubectl delete -f creds/serviceaccount.yaml
kubectl delete cm tokens-configmap
kubectl delete -f pvcs/shared-workspaces.yaml

# deleting tasks
kubectl delete -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-clone/0.1/git-clone.yaml
kubectl delete -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/replace-tokens/0.1/replace-tokens.yaml
# kubectl delete -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/sonarqube/sonarqube.yaml
kubectl delete -f https://raw.githubusercontent.com/vinamra28/catalog/vinamra28/sonar-fix/sonarqube/sonarqube.yaml
kubectl delete -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/buildah/0.1/buildah.yaml
kubectl delete -f tasks/blue-green-deploy.yaml
# installing the pipeline
kubectl delete -f pipelines/deployment-pipeline.yaml
