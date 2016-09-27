HomeRoute = require './home/route'

# # # # #

class HomeRouter extends Backbone.Routing.Router

  routes:
    '(/)':  'home'

  home: ->
    plugins?.deviceFeedback.haptic()
    plugins?.deviceFeedback.acoustic()
    new HomeRoute({ container: window.Container })

# # # # #

module.exports = new HomeRouter()
