class nccWebui.Views.DeviceFeatureView extends Backbone.View
  template: JST['app/scripts/templates/device_feature.ejs']
  className: 'list-group-item feature'

  events:
    'click a': 'useFeature'

  initialize: (options) ->
    @device = options.device
    @feature = options.feature

  render: ->
    @$el.html @template @feature
    return @

  useFeature: (e) ->
    e.preventDefault()
    text = $(e.target).data('name')
    action = text.split(':')
    meta = @device.getFeatureMetadata(action)
    view = new nccWebui.Views.DeviceFeatureResponseModalView
      device:@device
      feature: @feature
      action: action
      meta: meta
    modal = new Backbone.BootstrapModal(_.extend({
      content: view
      title: "#{@device.get('name')}>#{text}"
      animate: true
      okText: "Done"
      cancelText: false
    }, (meta.modal?={}))).open()
    view.ok = modal.$('.modal-footer .btn.ok')
    view.ok.button('loading')
    @device.useFeature action, meta, (err,res) ->
      view.render(err,res, modal)
      view.ok.button('reset')
