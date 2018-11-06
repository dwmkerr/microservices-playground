#!/usr/bin/env bash

# Create or load a unique id. We use this for things like the project name for
# GCP, which must be globally unique.
if [[ -e './unique_id' ]]; then
    CMP_UNIQUE_ID=$(cat ./unique_id)
    echo "Loaded Unique ID ${CMP_UNIQUE_ID}"
else
    # Create and save a five digit random number.
    CMP_UNIQUE_ID=$(( ${RANDOM} + 32767 ))
    echo ${CMP_UNIQUE_ID} >> ./unique_id
    echo "Created Unique ID ${CMP_UNIQUE_ID}"
fi

# Setup the env vars.
CMP_BASE_NAME="cloud-ms-platforms"
CMP_PROJECT_NAME="${CMP_BASE_NAME}-${CMP_UNIQUE_ID}"

# For the operator's info, show the env vars.
echo "CMP Variables"
echo "  CMP_UNIQUE_ID    : ${CMP_UNIQUE_ID}"
echo "  CMP_BASE_NAME    : ${CMP_BASE_NAME}"
echo "  CMP_PROJECT_NAME : ${CMP_PROJECT_NAME}"
