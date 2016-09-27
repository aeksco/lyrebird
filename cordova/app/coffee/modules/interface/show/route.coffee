Mouse    = require './views/mouse'
Keyboard = require './views/keyboard'
Remote   = require './views/remote'
Gamepad  = require './views/gamepad'

# # # # #

class InterfaceShowRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  render: (id) ->
    if id == 'mouse'
      view = new MouseInterface()

    else if id == 'keyboard'
      view = new LayoutView({ interface: id })

    @container.show(view) if view

# # # # #

module.exports = InterfaceShowRoute
