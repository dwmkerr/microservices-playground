//  send-otp-route.js
//
//  Defines a route for the Send OTP API.
const Joi = require('joi');
const pack = require('../../package.json');

module.exports = {
  method: 'GET',
  path: '/healthcheck',
  options: {
    description: 'Healthcheck',
    notes: 'Basic service health details',
    tags: ['api'],
    response: {
      status: {
        200: Joi.object().unknown(),
      },
    },
  },
  handler: async () => {
    return {
      status: 'ok',
      package: pack,
    };
  },
};
