HomeRoute = require './home/route'

# # # # #

class HomeRouter extends Backbone.Routing.Router

  routes:
    '(/)':  'home'

  home: ->
    new HomeRoute({ container: window.Container })

# # # # #

module.exports = new HomeRouter()
