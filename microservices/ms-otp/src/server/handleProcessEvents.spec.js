const sinon = require('sinon');
const { handleUnhandledRejections, handleSignals } = require('./handleProcessEvents');

describe('handleProcessEvents', () => {
  describe('handleUnhandledRejections', () => {
    it('should log and shut down the server if an rejection is unhandled', (done) => {
      //  Create the fake server and stub process.exit.
      const server = {
        stop: sinon.fake(),
        log: sinon.fake(),
      };
      sinon.stub(process, 'exit');

      //  Handle unhandled rejections.
      handleUnhandledRejections(process, server);

      //  After the unhandled rejection is handled, we can check that we logged
      //  and exited.
      process.once('unhandledRejection', () => {
        sinon.assert.calledOnce(server.log);
        sinon.assert.calledWith(process.exit, 1);
        done();
      });

      //  Simulate an unhandled rejection.
      process.emit('unhandledRejection');
    });
  });

  describe('handleSignals', () => {
    //  TODO: loop over signals to test each one.
    xit('should log and shut down the server if a SIGINT is sent', (done) => {
      //  Create the fake server and stub process.exit.
      const server = {
        stop: sinon.fake(),
        log: sinon.fake(),
      };
      sinon.stub(process, 'exit');

      //  Handle signals. Then send SIGINT.
      handleSignals(process, server);

      //  Once the signal has been sent, we can check the expectations are met
      //  and stop the test.
      setTimeout(() => {
        //  Expect a log message with SIGINT and a shutdown call.
        sinon.assert.calledWith(process.exit, 0);
        sinon.assert.calledOnce(server.stop);
        sinon.assert.calledOnce(server.log);
        done();
      }, 4000);

      process.emit('SIGINT');
    });

    afterEach(() => {
      //  Restore the default sandbox.
      sinon.restore();
    });
  });
});
