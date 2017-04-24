# InterfaceView = require './views/all'
InterfaceView = require './views/onsen'

# # # # #

# InterfaceRouter class definition
# This is the route that is reponsible for displaying
# interfaces inside the application.
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

  render: (param="type=keyboard") ->
    console.log 'RENDER InterfaceView'
    # type = param.split('=')[1]
    @container.show new InterfaceView({ type: type })
    # localStorage.lastRoute = '#interface?type=' + type # TODO - fix this?

# # # # #

module.exports = InterfaceShowRoute
