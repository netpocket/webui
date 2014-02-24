//= require spec_helper
//= require ncc

describe("BrowserConnection", function() {

  var socket = null,
      conn = null,
      call = null;

  beforeEach(function() {
    socket = {
      on: sinon.stub(),
      write: sinon.stub()
    };
    conn = new BrowserConnection(socket, app);
  });

  describe("identification", function() {
    beforeEach(function() {
      call = socket.on.getCall(0);
    });
    it("listens for identification request", function() {
      expect(socket.on.getCall(0).args[0]).to.eq('please identify');
    });
    it("identifies as a web browser", function() {
      call.args[1]();
      expect(socket).to.write('i am a web browser');
    });
  });


  describe("device add", function() {
    beforeEach(function() {
      call = socket.on.getCall(1);
      sinon.stub(app.devices, 'add');
    });

    it("listens for the device add message", function() {
      expect(call.args[0]).to.eq('a wild device appears');
    });

    it("adds it to the device collection", function() {
      var data = {id: 'c'};
      var attrs = {features: {}};
      call.args[1](data, attrs);
      var extended = {id: 'c', features: {}};
      expect(app.devices.add).to.have.been.calledWith(extended);
    });

    afterEach(function() {
      app.devices.add.restore();
    });
  });

  describe("device remove", function() {
    beforeEach(function() {
      call = socket.on.getCall(2);
      sinon.stub(app.devices, 'remove');
    });

    it("listens for the device remove message", function() {
      expect(call.args[0]).to.eq('a wild device disconnected');
    });

    it("removes it from the device collection", function() {
      var data = {id: 'c'};
      call.args[1](data);
      expect(app.devices.remove).to.have.been.calledWith(data);
    });

    afterEach(function() {
      app.devices.remove.restore();
    });
  });
});

