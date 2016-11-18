
# BaseRoute class - attaches container option (Marionette.Region instance) as class property
class BaseRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

# # # # #

module.exports = BaseRoute
