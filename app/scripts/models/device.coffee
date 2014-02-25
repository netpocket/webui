'use strict';

class nccWebui.Models.DeviceModel extends Backbone.Model
  useFeature: (name, callback) ->
    args = name.split(':')
    nccWebui.connection.socket.once "device:#{@get('id')}", (payload) ->
      if (payload.cmd is "feature response" && _.isEqual(payload.args, args))
        callback(payload.err, payload.res)
    nccWebui.connection.emit "device:#{@get('id')}",
      listen: "once"
      cmd: 'feature request'
      args: args
