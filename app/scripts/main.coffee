window.nccWebui =
    Models: {}
    Collections: {}
    Views: {}
    Routers: {}
    init: ->
        'use strict'
        @router = new nccWebui.Routers.NccRouter()
        console.log 'Hello from Backbone!'
        Backbone.history.start()

$ ->
    'use strict'
    nccWebui.init()
