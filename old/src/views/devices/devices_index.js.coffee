class NetpocketRails.Views.DevicesIndex extends Backbone.View
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
    device.view = new NetpocketRails.Views.Device(device)
    @$el.append(device.view.render().el)

  removeDevice: (device) ->
    device.view.remove()
