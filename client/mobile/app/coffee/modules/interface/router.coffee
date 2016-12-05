ShowRoute = require './show/route'

# # # # #

# InterfaceRouter class definition
class InterfaceRouter extends require '../base/router'

  routes:
    'interface(/)': 'show'

  show: (id) ->
    new ShowRoute({ container: @container, id: id })

# # # # #

module.exports = new InterfaceRouter({ container: window.Layout.mainRegion })
