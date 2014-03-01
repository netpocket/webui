class nccWebui.Views.DeviceFeaturesView extends Backbone.View
  initialize: (options) ->
    @device = options.device
    @features = @device.get('features')

  render: ->
    @$el.html('')
    for name, actions of @features
      @renderFeature name, actions
    return @

  renderFeature: (name, actions) ->
    view =  new nccWebui.Views.DeviceFeatureView({
      device:@device
      feature:{
        name: name
        actions: actions
      }
    })
    @$el.append(view.render().el)
