# ☁️🐳 microservices-playground

(Note: I'm currently merging multiple projects into this one, it might be a bit messy for a while, please be patient while I consolidate! Note what you'd like to see in the issues).

This project lets you spin up microservice platforms on the cloud in seconds. You can use it to evaluate the differences between different platforms.

The software is a simple messaging platform built with microservices. Perfect for testing out microservice technology like Kubernetes, Helm, Istio, etc.


| Platform                               | Status |
|----------------------------------------|--------|
| AWS - Kubernetes on Virtual Machines   | TODO   |
| AWS - ECS                              | Ready!   |
| AWS - Fargate                          | TODO   |
| AWS - EKS                              | TODO   |
| Azure - Kubernetes on Virtual Machines | TODO   |
| Azure - AKS                            | TODO   |
| GCP - Kubernetes on Virtual Machines   | TODO   |
| GCP - GKE                              | TODO   |

## Introduction

The goal of this project is to allow an expert to demo different cloud based microservice platforms quickly and easily. This can help teams evaluate which platform might be right for them.

1. For each platform, the infrastructure is setup via the cloud's CLI or Terraform.
2. If software is required, it is installed with Ansible.
3. For each platform, a network of microservices can be deployed to show the platform in action.

## Prerequisites

For each cloud provider, there are specific requirements. Install them all to ensure that you can build each platform. You will also need to install Docker and the Kubernetes CLI.

This guide assumes you are using a Mac.

### Kubernetes

Install the [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/):

```sh
brew install kubectl
```

If you use k8s a lot, consider `alias k='kubectl'`.
## Kubernetes

1.9 or greater required. To deploy to minikube, run:

```sh
cd ./kubernetes
minikube start
./create.sh
```

## Helm

The [Helm](https://helm.sh/) chart for the project is at `helm-meznger`. The name is not idiomatic (preferred would be `meznger`) but makes it clearer when looking at the directories to see what is what.

Generate the Kubernetes configurations locally to see what will be created with:

```sh
helm install --dry-run --debug \
    --set-string twilio.sid="$TWILIO_SID" \
    --set-string twilio.authToken="$TWILIO_AUTH_TOKEN" \
    --set-string twilio.phoneNumber="$TWILIO_PHONE_NUMBER" \
    .
```

To install, run:

```sh
helm install \
    --set-string twilio.sid="$TWILIO_SID" \
    --set-string twilio.authToken="$TWILIO_AUTH_TOKEN" \
    --set-string twilio.phoneNumber="$TWILIO_PHONE_NUMBER" \
    .
```

### GCP

First, install the GCP Cloud SDK:

```sh
curl https://sdk.cloud.google.com | bash
```

Follow the instructions, then restart your shell and initialise your environment:

```sh
exec -l $SHELL
gcloud init
```

## Usage

| Command | Description |
|---------|-------------|
| `make gcp-gke-setup` | Setup GCP GKE. |
| `make gcp-gke-teardown` | Teardown GCP GKE. |
## TODO

- [] ms-otp: If there are no Twilio credentials, should not send messages. We would have a static page which renders sent OTPs for the purpose of demoing.
- [ ] The helm chart will not restart services if the secrets change. We could make the secret name contain the release name, or sha values or something to force a restart, but not super urgent right now.
- [ ] The need for lots of env vars is a pain, as we cannot tell Helm to use the local env by preference.
- [ ] Consider renaming to microservices-playground
