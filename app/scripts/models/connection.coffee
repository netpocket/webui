'use strict'

class nccWebui.Models.ConnectionModel extends Backbone.Model
  defaults:
    tail: {}

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
      @emit @ident, @token, @tailData?={}
    @socket.on 'a wild device appears', (device, data) =>
      @devices.add(_.extend(device, data))
    @socket.on 'a wild device disconnected', (device) =>
      @devices.remove(device)
    @isStreaming = {}

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

  # pattern for a stream
  # might be overthinking this -- archive for now
  doStream: (featuretask, options) ->
    name = "#{options.target}:stream:#{featuretask}"
    @doRequestResponse
      type: 'relay'
      target: options.target
      args: ['open', 'stream', name]
      callback: =>
        if false # @isStreaming[name]? and @isStreaming[name].isActive
          console.log("stream #{name} has not yet ended")
          false
        else
          @isStreaming[name] = {isActive: true, done: options.callback}
          onChunk = =>
            console.log("got chunk", chunk)
          onEnd = =>
            console.log("done receiving chunks, you can stop listening")
            @socket.removeListener "#{name}:chunk", onChunk
            @socket.removeListener "#{name}:end", onEnd
            @isStreaming[name].done()
            @isStreaming[name] = null
            @doRequestResponse
              type: 'relay'
              target: options.target
              args: ['close', 'stream', name]
              callback: options.callback
          @socket.on "#{name}:chunk", onChunk
          @socket.on "#{name}:end", onEnd
          @emit "#{name}:begin"
