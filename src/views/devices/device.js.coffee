class NetpocketRails.Views.Device extends Backbone.View
  events:
    'click .feature .actions a': 'useFeature'

  template: JST['devices/device']
  className: "device"

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
