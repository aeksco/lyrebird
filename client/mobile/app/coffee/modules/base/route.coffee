
# BaseRoute class - attaches container option (Marionette.Region instance) as class property
class BaseRoute extends Backbone.Routing.Route

  routeName: null

  initialize: (options={}) ->
    @container = options.container
    localStorage.lastRoute = @routeName if @routeName

# # # # #

module.exports = BaseRoute
