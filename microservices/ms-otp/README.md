# ms-otp

One-Time-Pin Microservice. Provides APIs to send and validate SMS OTPs. Will integrate with [Twilio](https://twilio.com) if the appropriate environment variables are provided.

<!-- vim-markdown-toc GFM -->

* [Quickstart](#quickstart)
* [Configuration](#configuration)
* [Testing](#testing)
* [Building & Deploying](#building--deploying)

<!-- vim-markdown-toc -->

## Quickstart

Install dependencies and run:

```sh
npm i
npm start

# Or if you want to debug...
npm run debug

# Or if you want to auto-reload on code changes...
npm run dev
```

Open [`http://localhost:3000`](http://localhost:3000) to see the interactive Swagger Documentation, which you can use to hit the server APIs.

## Configuration

Configure the service with the following variables:

| Environment Variable           | Example                                                  | Usage                                                        |
| ------------------------------ | -------------------------------------------------------- | ------------------------------------------------------------ |
| **General**                    |
| `HOST`                         | `0.0.0.0`                                                | Host to expose the service on. Shouldn't need to change.     |
| `PORT`                         | `3000`                                                   | Port to expose the service on. Shouldn't need to change.     |
| **Twilio**                     |
| `TWILIO_SID`                   | `xxx`                                                    | The Twilio Service Account ID.                               |
| `TWILIO_AUTH_TOKEN`            | `xxx`                                                    | The Twilio Auth Token.                                       |
| `TWILIO_PHONE_NUMBER`          | `xxx`                                                    | The Twilio Phone number.                                     |

If `TWILIO_SID` is provided, the service will use the given Twilio config to actually send OTPs via SMS. If `TWILIO_SID` is *not* provided, the service will run in a test mode which outputs to standard-out only.

## Testing

Run tests with:

```sh
npm test
```

The easiest way to debug tests is to first make sure that only the test in question is running, use the [`only`](https://mochajs.org/#exclusive-tests) trick and add a 'debugger' statement:

```js
describe('Some fixture', () => {
  it.only('should do something' => {
    //  Only this test'll run....
  });
});
```

Then run the test in a debugger with `npm run test:debug`.

Coverage data is written in HTML and `lcov` format to the `./artifacts/coverage` directory.

## Building & Deploying

Build, test and push images with:

```bash
make build
make test
make push
```

The `makefile` will *always* build an image which is tagged with the current short SHA. It will then copy that image to a tag called `latest`. You can control the tags used with the options below.

You can control the built images with the following environment variables:

| Environment Variable | Usage |
|----------------------|-------|
| `DOCKER_REGISTRY`    | The registry to push to. Defaults to the Docker Hub. |
| `IMAGE_NAMESPACE`    | The namespace to push to. Defaults to `meznger`. |
| `IMAGE_NAME`    | The name of the image. Defaults the folder name, i.e. `ms-otp`. |
| `IMAGE_TAG`    | The of the image which should be set when building/deploying. Defaults to `latest`. |

The CI/CD process simply needs to call `test`, `build` and `push`. It can use environment variables to control where the artifacts are published to. Generally we will be tagging with version numbers or SHAs (using the `IMAGE_TAG` variable) before deploying to any kind of artifact repository.
