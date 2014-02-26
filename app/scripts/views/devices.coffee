'use strict';

class nccWebui.Views.DevicesView extends Backbone.View
  className: 'devices'

  initialize: (@collection) ->
    @listenTo @collection, "reset", @render
    @listenTo @collection, "remove", @removeDevice
    @listenTo @collection, "add", @renderDevice

  render: ->
    @$el.html('')
    @collection.each (device) =>
      @renderDevice device
    return @

  renderDevice: (device) ->
    device.view = new nccWebui.Views.DeviceView({model:device})
    @$el.append(device.view.render().el)

  removeDevice: (device) ->
    device.view.remove()
