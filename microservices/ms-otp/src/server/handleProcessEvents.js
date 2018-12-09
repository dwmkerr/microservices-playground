//  handleProcessEvents.js
//
//  Exports functions which can be used to allow a server to handle events from
//  a process, such as signals or unhandled rejections.

//  The signals we want to handle.
const signals = [
  // e.g. on Ctrl+C in a terminal...
  'SIGINT',
  // e.g. on 'docker stop'...
  'SIGTERM',
];

/**
 * handleUnhandledRejections - stop the 'server' object on an unhandled
 * rejection.
 *
 * @param process - the global process object.
 * @param server - the Hapi.js server object.
 */
function handleUnhandledRejections(process, server) {
  process.on('unhandledRejection', (err) => {
    //  We cannot safely stop the server, as we've got no idea what state we
    //  might be in. Better to log and abort.
    server.log(['error'], `An unhandled rejection occurred: ${err}`);
    process.exit(1);
  });
}

/**
 * handleSignals - cleanly exit the 'server' object on SIGINT or SIGTERM.
 *
 * @param process - the global process object.
 * @param server - the Hapi.js server object.
 */
function handleSignals(process, server) {
  //  Create a handler for each signal...
  signals.forEach((signal) => {
    process.on(signal, async () => {
      server.log(['info'], `Received signal ${signal}. Gracefully shutting down`);
      try {
        //  Stop the server. This call is async, so we must await it.
        await server.stop({});
      } catch (error) {
        server.log(['error'], `An error occurred shutting down the server: ${error}`);
        process.exit(1);
      }

      //  We successfully and cleanly shut down.
      process.exit(0);
    });
  });
}

module.exports = {
  signals,
  handleUnhandledRejections,
  handleSignals,
};
