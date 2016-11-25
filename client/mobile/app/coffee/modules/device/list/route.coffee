LayoutView  = require './views/layout'

# # # # #

class DeviceListRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: ->
    return Backbone.Radio.channel('device').request('collection').then (devices) =>
      @collection = devices

  render: (id) ->
    @container.show new LayoutView({ collection: @collection })

# # # # #

module.exports = DeviceListRoute
