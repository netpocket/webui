class NetpocketRails.Models.Device extends Backbone.Model
  useFeature: (name, callback) ->
    args = name.split(':')
    app.connection.socket.once "device:#{@get('id')}", (payload) ->
      if (payload.cmd is "feature response" && _.isEqual(payload.args, args))
        callback(payload.err, payload.res)
    app.connection.emit "device:#{@get('id')}", {
      listen: "once",
      cmd: 'feature request',
      args: args
    }
