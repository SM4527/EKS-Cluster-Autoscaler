# Project Title

EKS-Cluster-Autoscaler

## Description

Deploy Cluster Autoscaler on an EKS cluster using Terraform and Helm.

## Getting Started

### Dependencies

* docker & docker-compose
* aws user with programmatic access and high privileges 
* linux terminal
* Deploy an [EKS K8 Cluster](https://github.com/SM4527/EKS-Terraform) with Self managed Worker nodes on AWS using Terraform.
* Deploy a [Metrics server](https://github.com/SM4527/EKS-Metrics-server) on the above EKS cluster using Terraform and Helm.

### Installing

* clone the repository
* set environment variable TF_VAR_AWS_PROFILE
* review terraform variable values in variables.tf, locals.tf
* override values in the Helm chart through the "chart_values.yaml" file
* update kubernetes.tf with the AWS S3 bucket name and key name from the output of the [EKS K8 Cluster](https://github.com/SM4527/EKS-Terraform/blob/master/outputs.tf)

### Executing program

* Configure AWS user with AWS CLI.

```
docker-compose run --rm aws configure --profile $TF_VAR_AWS_PROFILE

docker-compose run --rm aws sts get-caller-identity
```

* Specify appropriate Terraform workspace.

```
docker-compose run --rm terraform workspace show

docker-compose run --rm terraform workspace select default
```

* Run Terraform apply to create the EKS cluster, k8 worker nodes and related AWS resources.

```
./run-docker-compose.sh terraform init

./run-docker-compose.sh terraform validate

./run-docker-compose.sh terraform plan

./run-docker-compose.sh terraform apply
```

* Verify kubectl calls and ensure Cluster Autoscaler Pod is in Running status.

```
./run-docker-compose.sh kubectl get pods -A | grep -i autoscaler
```

* Check the logs of the cluster-autoscaler deployment to view the scale-in and scale-out actions.

```
./run-docker-compose.sh kubectl logs -f deploy/cluster-autoscaler-aws-cluster-autoscaler -n kube-system
```

## Help

* kubernetes-autoscaler-nottriggerscaleup-pod-didnt-trigger-scale-up

```
Issue: cluster-autoscaler did not trigger ASG to add worker nodes

Fix:
Added below 2 tags to ASG of self managed node groups.
"k8s.io/cluster-autoscaler/enabled" = "TRUE"
"k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
```

Reference: https://stackoverflow.com/questions/58034203/kubernetes-autoscaler-nottriggerscaleup-pod-didnt-trigger-scale-up-it-would

## Authors

[Sivanandam Manickavasagam](https://www.linkedin.com/in/sivanandammanickavasagam)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Repo rosters

### Stargazers

[![Stargazers repo roster for @SM4527/EKS-Cluster-Autoscaler](https://reporoster.com/stars/dark/SM4527/EKS-Cluster-Autoscaler)](https://github.com/SM4527/EKS-Cluster-Autoscaler/stargazers)
