# https://github.com/powmedia/backbone.bootstrap-modal

class nccWebui.Views.DeviceFeatureResponseModalView extends Backbone.View

  initialize: (options) ->
    @device = options.device

  render: (err, res) =>
    if res?
      @$el.html "<p>#{res}</p>"
    else if err?
      @$el.html "<p>#{err}</p>"
    else
      @$el.html "<p>Waiting for device response ... </p>"
    # html =>
    #   if (err)
    #     @display.html('<pre>'+JSON.stringify(err)+'</pre>')
    #   else if (res)
    #     switch res.contentType
    #       when "image/url"
    #         @display.html('<img src="'+res.content+'"/>')
    #       when "image/jpg (base64)"
    #         @display.html('<img src="data:image/jpeg;base64,'+res.content+'"/>')
    #       when "text/plain"
    #         $('#myModal').modal(options)
    #       else
    #         # Assume it's just text or JSON
    #         @display.html('<pre>'+js_beautify(JSON.stringify(res))+'</pre>')
    return @
