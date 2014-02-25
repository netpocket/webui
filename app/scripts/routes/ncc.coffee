'use strict';

class nccWebui.Routers.NccRouter extends Backbone.Router
    routes:
        'devices/:token/:host': 'devices'

    devices: (token, host) ->
        console.log "connecting to ", host
        @devices = new nccWebui.Collections.DevicesCollection()
        @connection = new nccWebui.Models.ConnectionModel()
        @connection.devices = @devices
        @connection.set('token', token)
        @connection.set('url', 'http://'+host)
        @connection.continue()

