'use strict';

class nccWebui.Routers.NccRouter extends Backbone.Router
    routes:
        'connect/:host': 'connect'

    connect: (host) ->
        console.log "connecting to ", host
