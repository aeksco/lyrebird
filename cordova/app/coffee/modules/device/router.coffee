Service = require './service'
ListRoute = require './list/route'
ShowRoute = require './show/route'

# # # # #

class DeviceRouter extends Backbone.Routing.Router

  routes:
    'devices(/)':          'list'
    'devices/:id(/)':      'show'

  list: ->
    plugins?.deviceFeedback.haptic()
    plugins?.deviceFeedback.acoustic()
    new ListRoute({ container: window.Container })

  show: (id) ->
    plugins?.deviceFeedback.haptic()
    plugins?.deviceFeedback.acoustic()
    new ShowRoute({ container: window.Container, id: id })

# # # # #

module.exports = new DeviceRouter()
