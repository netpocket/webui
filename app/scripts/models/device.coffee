'use strict'

class nccWebui.Models.DeviceModel extends Backbone.Model
  subscribeTo: (socket) ->
    socket.on "device:#{@get('id')}:changed", (changes) =>
      @set(changes)

  useFeature: (name, callback) ->
    path = name.split(':')
    options = @featureFactory(path, callback)
    meta = @get('features')
    _.each path, (i) ->
      meta = meta[i] if meta[i]?
    meta
    if meta.stream is true
      nccWebui.connection.doStream name, options
    else
      nccWebui.connection.doRequestResponse options

  featureFactory: (path, callback) ->
    type: 'feature'
    target: "device:#{@get('id')}"
    args: path
    callback: callback

