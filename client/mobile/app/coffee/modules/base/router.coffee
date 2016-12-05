
# BaseRouter class definition
# The base router reduces repeated code by
# attaching the @container property passed in from when instantiated.
# This property is subsequently passed to all routes created inside
# routers subclassed from this definition
class BaseRouter extends Backbone.Routing.Router

  initialize: (options) -> @container = options.container

# # # # #

module.exports = BaseRouter
