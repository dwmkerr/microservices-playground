#!/usr/bin/env bash

# Delete the cluster. The project can remain, it's just a container for resources
# and doesn't cost anything. It also means subsequent setups are cleaner.
gcloud container clusters delete ${CMP_BASE_NAME}
