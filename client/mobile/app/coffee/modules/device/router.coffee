Service = require './service'
ListRoute = require './list/route'
ShowRoute = require './show/route'

# # # # #

# DeviceRouter class definition
class DeviceRouter extends require '../base/router'

  routes:
    '(/)':                 'list'
    'devices(/)':          'list'
    'devices/:id(/)':      'show'

  list: ->
    new ListRoute({ container: @container })

  show: (id) ->
    new ShowRoute({ container: @container, id: id })

# # # # #

module.exports = new DeviceRouter({ container: window.Layout.mainRegion })
