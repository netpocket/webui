'use strict'

class nccWebui.Models.DeviceModel extends Backbone.Model
  useFeature: (name, callback) ->
    nccWebui.connection.doRequestResponse
      type: 'feature'
      target: "device:#{@get('id')}"
      args: name.split(':')
      callback: callback

