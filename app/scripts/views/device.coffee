'use strict';

class nccWebui.Views.DeviceView extends Backbone.View
  template: JST['app/scripts/templates/device.ejs']
  className: "device panel panel-default"

  events:
    'click .feature a': 'useFeature'

  initialize: (options) ->
    @device = options.model
    @listenTo @device, "change", @render

  render: ->
    @$el.html @template @device.attributes
    @display = @$('.display')
    return @

  useFeature: (e) ->
    e.preventDefault()
    @display.html('<span>Please wait...</span>')
    @device.useFeature $(e.target).data('name'), (err, res) =>
      if (err)
        @display.html('<pre>'+JSON.stringify(err)+'</pre>')
      else if (res)
        switch res.contentType
          when "image/url"
            @display.html('<img src="'+res.content+'"/>')
          when "image/png"
            @display.html('<img src="data:image/png;base64,'+res.content+'"/>')
          else
            # Assume it's just text or JSON
            @display.html('<pre>'+js_beautify(JSON.stringify(res))+'</pre>')
