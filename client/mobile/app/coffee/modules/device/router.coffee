Service = require './service'
ListRoute = require './list/route'
ShowRoute = require './show/route'

# # # # #

class DeviceRouter extends Backbone.Routing.Router

  routes:
    '(/)':                 'list'
    'devices(/)':          'list'
    'devices/:id(/)':      'show'

  list: ->
    new ListRoute({ container: window.Container })

  show: (id) ->
    new ShowRoute({ container: window.Container, id: id })

# # # # #

module.exports = new DeviceRouter()
