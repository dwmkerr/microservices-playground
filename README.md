# microservices-meznger

[![GuardRails badge](https://badges.production.guardrails.io/dwmkerr/microservices-meznger.svg)](https://www.guardrails.io)

A simple messaging platform built with microservices. Perfect for testing out microservice technology like Kubernetes, Helm, Istio, etc.

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

## TODO

- [] ms-otp: If there are no Twilio credentials, should not send messages. We would have a static page which renders sent OTPs for the purpose of demoing.
- [ ] The helm chart will not restart services if the secrets change. We could make the secret name contain the release name, or sha values or something to force a restart, but not super urgent right now.
- [ ] The need for lots of env vars is a pain, as we cannot tell Helm to use the local env by preference.
