#!/usr/bin/env bash

# Destroy the Kubernetes objects.
kubectl delete -f deployment.yaml

# Delete the Twilio secret.
kubectl delete secret twilio
