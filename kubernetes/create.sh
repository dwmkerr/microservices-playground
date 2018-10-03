#!/usr/bin/env bash

function assert_env() {
    name=$1
    if [[ -z ${!name} ]]; then
        echo "error: Environment var '$name' must be set"
        exit 1
    fi
}

assert_env TWILIO_SID
assert_env TWILIO_AUTH_TOKEN
assert_env TWILIO_PHONE_NUMBER

# Create the Twilio secret.
kubectl create secret generic twilio \
    --from-literal=sid=$TWILIO_SID \
    --from-literal=authToken=$TWILIO_AUTH_TOKEN \
    --from-literal=phoneNumber=$TWILIO_PHONE_NUMBER

# Create the Kubernetes objects.
kubectl create -f deployment.yaml
kubectl create -f service.yaml
