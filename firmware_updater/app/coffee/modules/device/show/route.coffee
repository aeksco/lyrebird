LayoutView  = require './views/layout'

# # # # #

class DeviceShowRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: (id) ->
    return Backbone.Radio.channel('device').request('model', id).then (contact) =>
      @model = contact

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = DeviceShowRoute
