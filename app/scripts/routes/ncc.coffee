'use strict'

class nccWebui.Routers.NccRouter extends Backbone.Router
    routes:
        'ncc/:token/:host': 'index'

    index: (token, host) ->
        coll = new nccWebui.Collections.DevicesCollection()
        view = new nccWebui.Views.DevicesView(coll)
        $('body .container').html(view.render().el)
        nccWebui.connection = new nccWebui.Models.ConnectionModel
          devices: coll
          token: token
          url: 'http://'+host
          ident: "i am a web browser"
