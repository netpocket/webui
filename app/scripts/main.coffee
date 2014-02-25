window.nccWebui =
    Models: {}
    Collections: {}
    Views: {}
    Routers: {}
    init: ->
        'use strict'
        @router = new nccWebui.Routers.NccRouter()
        Backbone.history.start()

$ ->
    'use strict'
    nccWebui.init()
