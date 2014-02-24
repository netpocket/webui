//= require spec_helper
//= require ncc

describe("app", function() {
  it("it initializes app.devices", function() {
    expect(app.devices).to.be.ok;
  });

  it("keeps a handle to the connection", function() {
    expect(app.connection).to.be.an.instanceof(BrowserConnection);
  });
});

describe("config", function() {
  var config = null;
  beforeEach(function() {
    config = window.config;
  });
 
  // TODO need a controller and view test
  // that makes sure these values are set correctly
  it("has url and spec keys", function() {
    expect(config).to.have.keys(['url','spec']);
  });
});
