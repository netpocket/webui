'use strict'

class nccWebui.Views.DeviceView extends Backbone.View
  template: JST['app/scripts/templates/device.ejs']
  className: "device panel panel-default"

  initialize: (options) ->
    @device = options.model
    @listenTo @device, "change", @render

  render: ->
    @$el.html @template @device.attributes
    @display = @$('.display')
    @renderFeatures()
    return @

  renderFeatures: ->
    @$('.feature').remove()
    @device.featuresView = new nccWebui.Views.DeviceFeaturesView({device:@device})
    @$('.list-group').append(@device.featuresView.render().el)


