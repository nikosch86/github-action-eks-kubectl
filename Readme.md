github-action-eks-kubectl
=============
Runs `kubectl` commands on **AWS EKS** Clusters.

## Usage

### Basic Example

```yml
name: deploy

on:
  - push

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: eu-west-1

      - uses: actions/checkout@v2
      - name: Run kubectl
        uses: nikosch86/github-action-eks-kubectl@main
        with:
          command: "apply -f deployment.yaml"
        env:
          EKS_CLUSTER: optional-cluster-name
```

## Config

### Basic

This action uses the AWS Access Key and Secret to operate `awscli` in order to generate the appropriate configuration for `kubectl`.

It depends on the `aws-actions/configure-aws-credentials` action to gain access.  

- **EKS_CLUSTER**: [optional] The Name of the EKS Cluster kubectl should operate on.

If not specified the action tries to list the clusters and pick the first one.
This will only work if the AWS API User has permission to list the clusters.

Proper IAM permissions to access the cluster are needed for successful deployment.
(more info [here](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)).

## Outputs

- **output**: Output of the `kubectl` command (including stdout and stderr).
