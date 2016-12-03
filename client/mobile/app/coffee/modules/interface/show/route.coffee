Mouse     = require './views/mouse'
Keyboard  = require './views/keyboard'
Remote    = require './views/remote'
Gamepad   = require './views/gamepad'
Numpad    = require './views/Numpad'

# # # # #

class InterfaceShowRoute extends require '../../base/route'

  fetch: (id) ->
    # Debug statement
    return true unless window.plugins

    # Check bluetooth enabled...
    # TODO - this should be moved elsewhere
    Backbone.Radio.channel('bluetooth').request('is:enabled')
    .then (isEnabled) => return true
    .catch (error) =>
      console.log 'Attempting to enable..'

      # Force bluetooth enabled...
      Backbone.Radio.channel('bluetooth').request('force:enable')
      .then () => return true
      .catch (error) => return false

  render: (id) ->
    switch id
      when 'mouse'    then view = new Mouse()
      when 'keyboard' then view = new Keyboard()
      when 'remote'   then view = new Remote()
      when 'gamepad'  then view = new Gamepad()
      when 'numpad'   then view = new Numpad()

    # TODO - fix this
    localStorage.lastRoute = '#interface/' + id

    @container.show(view)

# # # # #

module.exports = InterfaceShowRoute
