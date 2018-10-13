#!/usr/bin/env bash

# Fail on errors, show commands.
set -xe

# Configuration for our AKS setup.
resource_group_name=microservice-playground
resource_group_location=eastus
cluster_name=microservice-playground
cluster_node_count=3

# Delete the resource group, which will delete all associated resources.
az group delete \
    --name ${cluster_name} \
    --yes
