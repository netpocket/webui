# https://github.com/powmedia/backbone.bootstrap-modal

class nccWebui.Views.DeviceFeatureResponseModalView extends Backbone.View
  className: 'feature-response-modal-body'
  events:
    'ok': 'submit'

  initialize: (options) ->
    @device = options.device
    @feature = options.feature
    @action = options.action
    @meta = options.meta
    if @meta.submit?
      this.bind("ok", @submit)

  submit: (modal) ->
    return if @ok.hasClass('disabled')
    modal.$content.find('.alert').remove()
    @ok.button('loading')
    # TODO validation
    # harvest all inputs from the modal
    # in the same order as they were provided in the transform
    children = modal.$content.children()
    values = []
    inputs = _.filter @transform, (e, i) ->
      if _.contains(['input','select','textarea'], e.tag)
        values.push $(children.get(i)).val()
     # TODO show that it is working and we're waiting for response
     # TODO disable ok button until response is back
    modal.preventClose()
    @device.useFeature @action.concat(['submit']), {
      params: values
    }, (err, res) =>
      @ok.button('reset')
      modal.$content.prepend """
        <div class="alert alert-#{ if err then 'danger' else 'success' } alert-dismissable">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          #{ if err then err else res }
        </div>
      """

  render: (err, res, modal) =>
    if res?
      if (err)
        @$el.html('<pre>'+JSON.stringify(err)+'</pre>')
      else if (res)
        switch res.contentType
          when "image/url"
            @$el.html('<img src="'+res.content+'"/>')
          when "image/jpg (base64)"
            @$el.html('<img src="data:image/jpeg;base64,'+res.content+'"/>')
          when "text/plain"
            @$el.html('<pre>'+res.content+'</pre>')
          when "nos/form/json2html"
            @transform = res.transform
            @$el.json2html(res.data, @transform, {replace:true})
            modal.$content.find('input').on 'keyup', (e) =>
              if e.which is 13
                @submit(modal)
          else
            # Assume it's just text or JSON
            @$el.html('<pre>'+js_beautify(JSON.stringify(res))+'</pre>')
    else if err?
      @$el.html "<p>#{err}</p>"
    else
      @$el.html "<p>Waiting for device response ... </p>"
    return @

