//  Initialise New Relic. This *must* be the first line of the microservice.
const create = require('./server/create');
const { handleUnhandledRejections, handleSignals } = require('./server/handleProcessEvents');

const sendOtpRoute = require('./apis/send-otp-route');

/**
 * start - starts our server object.
 */
async function start() {
  //  Create and start the server. Any errors during creation are fatal.
  try {
    //  Create the server.
    const server = await create();

    //  Make sure we can handle unhandled rejections and signals.
    handleUnhandledRejections(process, server);
    handleSignals(process, server);

    //  Add all of the routes.
    server.route(sendOtpRoute);

    //  Start the server, log details of where it is running.
    await server.start();
    const { protocol, host, port } = server.info;
    server.log('info', `Server running at: ${protocol}://${host}:${port}`);
  } catch (err) {
    console.log(`An error occurred starting the server: ${err}`);
    process.exit(1);
  }
}

start();
