# microservices-meznger

A simple messaging platform built with microservices. Perfect for testing out microservice technology like Kubernetes, Helm, Istio, etc.

## Kubernetes

1.9 or greater required. To deploy to minikube, run:

```sh
cd ./kubernetes
minikube start
./create.sh
```

## Helm

The current helm chart is still work in progress.

## TODO

- [] ms-otp: If there are no Twilio credentials, should not send messages. We would have a static page which renders sent OTPs for the purpose of demoing.
