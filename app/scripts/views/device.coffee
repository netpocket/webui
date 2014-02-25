'use strict';

class nccWebui.Views.DeviceView extends Backbone.View
  template: JST['app/scripts/templates/device.ejs']
  tagName: 'li'
  className: "device"

  events:
    'click .feature .actions a': 'useFeature'

  initialize: (@device) ->
    @listenTo @device, "change", @render

  render: ->
    @$el.html @template @device.attributes
    return @

  useFeature: (e) ->
    e.preventDefault()
    console.log("please wait! don't click that one again!")
    @device.useFeature $(e.target).data('name'), (err, res) =>
      console.log("ok back!", err, res)
