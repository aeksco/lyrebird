LayoutView  = require './views/layout'
MouseInterface = require './views/mouse'

# # # # #

class InterfaceShowRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  render: (id) ->
    if id == 'mouse'
      view = new MouseInterface()

    else
      view = new LayoutView({ interface: id })

    @container.show(view)

# # # # #

module.exports = InterfaceShowRoute
