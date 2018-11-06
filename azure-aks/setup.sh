#!/usr/bin/env bash

# Fail on errors, show commands.
set -xe

# Configuration for our AKS setup.
kubernetes_version=1.11.3
resource_group_name=microservice-playground
resource_group_location=eastus
cluster_name=microservice-playground
cluster_node_count=1

# Create a resource group.
az group create \
    --name ${resource_group_name} \
    --location ${resource_group_location}

# Create an AKS cluster for the resource group.
az aks create \
    --resource-group ${resource_group_name} \
    --name ${cluster_name} \
    --node-count ${cluster_node_count} \
    --kubernetes-version ${kubernetes_version} \
    --enable-addons monitoring \
    --generate-ssh-keys

# Download credentials for the cluster, setting up the kubectl CLI with a new
# context.
az aks get-credentials \
    --resource-group ${resource_group_name} \
    --name ${cluster_name}

# Create the service account for tiller.
kubectl apply -f ./helm/helm-rbac.yaml

# Initialise Helm, using the appropriate account for Tiller.
helm init --service-account tiller --wait

