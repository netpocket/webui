window.nccWebui =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'
    console.log 'Hello from Backbone!'

$ ->
  'use strict'
  nccWebui.router = new nccWebui.Routers.NccRouter()
  nccWebui.init()
  Backbone.history.start()
