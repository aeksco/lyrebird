ShowRoute = require './show/route'

# # # # #

class InterfaceRouter extends Backbone.Routing.Router

  routes:
    'interface(/)': 'show'

  show: (id) ->
    new ShowRoute({ container: window.Container, id: id })

# # # # #

module.exports = new InterfaceRouter()
