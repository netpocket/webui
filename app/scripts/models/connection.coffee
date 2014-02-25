'use strict';

class nccWebui.Models.ConnectionModel extends Backbone.Model
    initialize: (options) ->
        _.extend(@, options)
        console.log "connecting to #{@url}"
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
