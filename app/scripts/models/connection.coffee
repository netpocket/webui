'use strict'

class nccWebui.Models.ConnectionModel extends Backbone.Model
  initialize: (options) ->
    _.extend(@, options)
    @socket = Primus.connect @url
    @socket.on 'open', ->
      console.log 'connected to relay'
    @socket.on 'data', (data) =>
      return if @socket.reserved(data.args[0])
      console.log 'got message', data.args
      @socket.emit.apply @socket, data.args
    @socket.on 'please identify', =>
      @emit 'i am a web browser', @token, {}
    @socket.on 'a wild device appears', (device, data) =>
      @devices.add(_.extend(device, data))
    @socket.on 'a wild device disconnected', (device) =>
      @devices.remove(device)

  emit: =>
    args = Array.prototype.slice.call(arguments, 0)
    console.log 'sent message', args
    @socket.write({args:args})

  # pattern for a request/response cycle
  doRequestResponse: (options) ->
    @socket.once options.target, (payload) ->
      sameCmd = payload.cmd is "#{options.type} response"
      sameArgs = _.isEqual(payload.args, options.args)
      options.callback(payload.err, payload.res) if (sameCmd and sameArgs)
    @emit options.target,
      listen: "once"
      cmd: "#{options.type} request"
      args: options.args
