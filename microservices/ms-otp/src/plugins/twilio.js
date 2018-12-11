//  twilio.js
//
//  A Hapi Plugin for interfacing with Twilio. Simply creates the twilio client,
//  which can then be used in routes. This is exposed as a plugin so that we can
//  initialise it on server startup, and fail fast if configuration is missing.
const Twilio = require('twilio');

module.exports = {
  name: 'twilio',
  version: '0.0.1',
  register: async (server, options) => {
    //  Get the twilio config. If it is missing, bail out.
    const { sid, authToken, phoneNumber } = options;

    //  If no service id has been provided, just create a mock client for testing.
    if (!sid) {
      let fakeSid = 0;
      server.log(['info'], 'no TWILIO_SID provided, SMS messages will *not* be sent');
      server.app.twilio = {
        sendMessage: async ({ to, body }) => {
          fakeSid += 1;
          server.log(['info'], `SMS ${fakeSid} to '${to}': ${body}`);
          return {
            sid: fakeSid,
          };
        },
      };
      return;
    }

    //  A service id has been provided, so we must validate the other paramerers.
    if (!authToken) throw new Error("'authToken' has not be provided in the twilio client options");
    if (!phoneNumber) throw new Error("'phoneNumber' has not be provided in the twilio client options");

    //  Initialise the client. Assign it to the 'app' so that it is available.
    try {
      const twilioClient = new Twilio(sid, authToken);
      server.app.twilio = {
        sendMessage: async ({ to, body }) => {
          return twilioClient.messages.create({ to, body, from: phoneNumber });
        },
      };
      server.log(['info'], `Created Twilio client with SID ${sid}`);
    } catch (err) {
      throw new Error(`An error occurred creating the twilio client: ${err}`);
    }
  },
};
