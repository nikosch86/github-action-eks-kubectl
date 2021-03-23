#!/bin/bash -eu
if [ ${EKS_CLUSTER:+1} ]; then
  echo "running on ${EKS_CLUSTER}"
else
  echo "no cluster specified using EKS_CLUSTER, trying to list clusters, picking first one"
  EKS_CLUSTER=$(aws eks list-clusters | jq -r '.clusters|first')
fi

echo "creating kubeconfig using AWS credentials"
aws eks --name=${EKS_CLUSTER} update-kubeconfig

echo "running kubectl $1"
output="$(kubectl $1 2>&1)"
exit_code=$?
echo "::set-output name=output::$output"
if [[ $exit_code -eq 0 ]]; then exit 0; else exit 1; fi
