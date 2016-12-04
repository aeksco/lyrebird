InterfaceView = require './views/all'

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
    # TODO - switch from ID to param
    @container.show new InterfaceView({ interface: id })

    # # TODO - fix this
    # localStorage.lastRoute = '#interface/' + id

    # @container.show(view)

# # # # #

module.exports = InterfaceShowRoute
