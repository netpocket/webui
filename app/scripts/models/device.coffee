'use strict'

class nccWebui.Models.DeviceModel extends Backbone.Model
  subscribeTo: (socket) ->
    socket.on "device:#{@get('id')}:changed", (changes) =>
      @set(changes)

  getFeatureMetadata: (path) ->
    meta = @get('features')
    _.each path, (i) ->
      meta = meta[i] if meta[i]?
    meta

  useFeature: (path, meta, callback) ->
    options = @featureFactory(path, callback)
    _.extend(options, meta)
    if meta.stream is true
      nccWebui.connection.doStream name, options
    else
      nccWebui.connection.doRequestResponse options

  featureFactory: (path, callback) ->
    type: 'feature'
    target: "device:#{@get('id')}"
    args: path
    callback: callback

