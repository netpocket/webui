//= require primus
//= require jquery
//= require_tree ./ncc
//= require underscore
//= require backbone
//= require netpocket_rails
//= require_tree ../templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./routers

// Will be moved to rails app
window.config = {
  // Rails app determine user's relay and drop this in the view
  //url: "http://netpocket-rails.dev:1337",
  url: 'http://ncc-relay.herokuapp.com',
  spec: {
    // Rails app fetch the spec and drop it in the view
    "version": "2.0.2",
    "pathname": "/primus",
    "parser": "json",
    "transformer": "sockjs"
  }
};

NetpocketRails.initialize = function() {
  "use strict";

  var app = window.app = {};

  app.devices = new NetpocketRails.Collections.Devices();
  app.devicesIndex = new NetpocketRails.Views.DevicesIndex(app.devices);
  app.devicesIndex.setElement($("body")).render();

  var socket = Primus.connect(config.url, config.spec);
  app.connection = new BrowserConnection(socket);

  socket.on('open', function () {
    console.log("Connected to relay");
  });

  socket.on('data', function (data) {
    if (socket.reserved(data.args[0])) return;
    console.log('got message', data.args);
    socket.emit.apply(socket, data.args);
  });

  socket.on('reconnecting', function() {
    //console.log('scheduling a reconnect.');
  });

  socket.on('reconnect', function() {
    //console.log("about to reconnect");
  });
};
