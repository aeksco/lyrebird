Service = require './service'
ListRoute = require './list/route'
ShowRoute = require './show/route'

# # # # #

class DeviceRouter extends require '../base/router'

  routes:
    'devices(/)':          'list'
    'devices/:id(/)':      'show'

  list: ->
    new ListRoute({ container: window.Layout.mainRegion })

  show: (id) ->
    new ShowRoute({ container: window.Layout.mainRegion, id: id })

# # # # #

module.exports = new DeviceRouter()
