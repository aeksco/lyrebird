LayoutView  = require './views/layout'

# # # # #

# DeviceListRoute class definition
class DeviceListRoute extends require '../../base/route'

  fetch: ->
    return Backbone.Radio.channel('device').request('collection').then (devices) =>
      @collection = devices

  render: ->
    @container.show new LayoutView({ collection: @collection })

# # # # #

module.exports = DeviceListRoute
