#!/usr/bin/env bash

gcloud projects create ${CMP_PROJECT_NAME}

# TODO: better than setting the default project would be to just specify
# it in each commandline call (it means we're not goofing with the operator's
# personal setup then)

# Set a default project and region.
gcloud config set project ${CMP_PROJECT_NAME}
gcloud config set compute/zone asia-southeast1

# Create our cluster.
gcloud container clusters create ${CMP_BASE_NAME}
