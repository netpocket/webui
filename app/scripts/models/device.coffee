'use strict'

class nccWebui.Models.DeviceModel extends Backbone.Model
  initialize: ->
    @pipes = []

  useFeature: (name, callback) ->
    path = name.split(':')
    options = @featureFactory(path, callback)
    if @featureMeta(path).pipe is true
      featurePipe(options)
    else
      nccWebui.connection.doRequestResponse options

  featureFactory: (path, callback) ->
    type: 'feature'
    target: "device:#{@get('id')}"
    args: path
    callback: callback

  featureMeta: (path) ->
    obj = @get('features')
    _.each path, (i) ->
      obj = obj[i] if obj[i]?
    obj

  featurePipe: (options) ->
    conn = new nccWebui.Models.ConnectionModel
      devices: coll
      token: token
      url: 'http://'+host
