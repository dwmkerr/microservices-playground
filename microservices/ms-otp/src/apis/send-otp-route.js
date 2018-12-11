//  send-otp-route.js
//
//  Defines a route for the Send OTP API.
const Joi = require('joi');

module.exports = {
  method: 'POST',
  path: '/send-otp',
  options: {
    description: 'Send OTP',
    notes: 'Sends an OTP to a given phone number',
    tags: ['api'],
    response: {
      status: {
        204: Joi.string().empty(''),
      },
      emptyStatusCode: 204,
    },
    validate: {
      payload: Joi.object({
        phoneNumber: Joi.string()
          .required()
          .description('the phone number'),
      }),
    },
  },
  handler: async (request) => {
    //  Send a message with twilio.
    try {
      const message = await request.server.app.twilio.sendMessage({
        body: 'Your OTP is: XXXX',
        to: request.payload.phoneNumber,
      });
      request.log(`Successfully sent message with sid ${message.sid}`);
      return null;
    } catch (err) {
      request.log('error', `An error occurred sending the message: ${err}`);
      throw err;
    }
  },
};
