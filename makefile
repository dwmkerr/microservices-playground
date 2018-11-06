# env sets up the env vars the scripts need.
env:
	./env

# Setup GCP GKE.
gcp-gke-setup: env
	./gcp/gke/setup.sh

# Teardown GCP GKE.
gcp-gke-teardown: env
	./gcp/gke/teardown.sh

.PHONY: env interface launchpad
