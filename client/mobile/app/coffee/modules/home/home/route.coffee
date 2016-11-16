LayoutView  = require './views/layout'

# # # # #

class HomeRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  render: ->
    @container.show new LayoutView()

# # # # #

module.exports = HomeRoute
