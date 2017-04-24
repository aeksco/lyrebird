
class AbstractAppRouter extends Mn.Service

  initialize: (options) ->
    @container = options.container

  invokeRoute: (route, args...) ->
    @currentRoute?.exit()
    @currentRoute = route
    @currentRoute.enter(args)

# # # # #

module.exports = AbstractAppRouter
