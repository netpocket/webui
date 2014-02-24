var BrowserConnection = (function(socket) {
  this.socket = socket;
  var token = Math.random().toString(36).substr(2);
  var attributes = {};

  var emit = this.emit = function() {
    var args = Array.prototype.slice.call(arguments, 0);
    console.log('sent message', args);
    socket.write({args:args});
  };

  socket.on('please identify', function() {
    emit('i am a web browser', token, attributes);
  });

  socket.on('a wild device appears', function(device, attributes) {
    app.devices.add(_.extend(device, attributes));
  });

  socket.on('a wild device disconnected', function(device) {
    app.devices.remove(device);
  });

});

window.BrowserConnection = BrowserConnection;

