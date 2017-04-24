HomeRoute = require './home/route'

# # # # #

# HomeRouter class definition
class HomeRouter extends require '../base/router'

  # routes:
  #   '(/)':  'home'

  # home: ->
  #   new HomeRoute({ container: @container })

# # # # #

module.exports = new HomeRouter({ container: window.Layout.mainRegion })
