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
    task = $(e.target).data('name')
    view = new nccWebui.Views.DeviceFeatureResponseModalView({device:@device})
    modal = new Backbone.BootstrapModal({
      content: view
      title: "#{@device.get('name')} #{task}"
      animate: true
    }).open()
    @device.useFeature task, view.render
