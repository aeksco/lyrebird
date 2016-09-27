LayoutView  = require './views/layout'

# # # # #

class InterfaceShowRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  render: (id) ->
    @container.show new LayoutView({ interface: id })

# # # # #

module.exports = InterfaceShowRoute
