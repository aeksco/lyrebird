Mouse    = require './views/mouse'
Keyboard = require './views/keyboard'
Remote   = require './views/remote'
Gamepad  = require './views/gamepad'

# # # # #

class InterfaceShowRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  render: (id) ->
    switch id
      when 'mouse'    then view = new Mouse()
      when 'keyboard' then view = new Keyboard()
      when 'remote'   then view = new Remote()
      when 'gamepad'  then view = new Gamepad()

    @container.show(view)

# # # # #

module.exports = InterfaceShowRoute
