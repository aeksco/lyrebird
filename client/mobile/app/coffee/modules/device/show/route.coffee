LayoutView  = require './views/layout'

# # # # #

# DeviceShowRoute class definition
class DeviceShowRoute extends require '../../base/route'

  fetch: (id) ->
    console.log 'FETCHING'
    console.log id
    return Backbone.Radio.channel('device').request('model', id).then (contact) =>
      @model = contact

  render: (id) ->
    console.log 'RENDER?'
    console.log @model
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = DeviceShowRoute
