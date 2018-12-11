const { expect } = require('chai');
const create = require('./create');

describe('create', () => {
  it('should resolve with a server object', async () => {
    const server = await create();
    expect(server).to.be.a('object');
  });
});
