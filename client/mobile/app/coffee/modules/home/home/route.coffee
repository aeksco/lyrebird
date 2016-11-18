LayoutView  = require './views/layout'

# # # # #

class HomeRoute extends require '../../base/route'

  fetch: ->
    promises = [
      Backbone.Radio.channel('known:device').request('collection')
      Backbone.Radio.channel('device').request('collection')
    ]

    return Promise.all(promises)
    .then (collections) =>
      @model      = collections[0].first() # KnownDevice
      @collection = collections[1] # DeviceCollection

  render: ->
    window.known = @model
    @container.show new LayoutView({ model: @model, collection: @collection })

# # # # #

module.exports = HomeRoute
