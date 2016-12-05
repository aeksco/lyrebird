
# BaseRoute class definition
# The base route reduces repeated code by
# attaching the @container property passed in from
# the router. This property is used to display views in the app
class BaseRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

# # # # #

module.exports = BaseRoute
