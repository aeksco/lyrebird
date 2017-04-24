
# BaseRouter class definition
# The base router reduces repeated code by
# attaching the @container property passed in from when instantiated.
# This property is subsequently passed to all routes created inside
# routers subclassed from this definition
class BaseRouter extends Backbone.Routing.Router

  initialize: (options) -> @container = options.container

# # # # #

module.exports = BaseRouter

# # # # #

# TODO - base router implementation should borrow heavily from Backbone.Routing.
# It should NOT make use of Backbone.History to manage state - it should manage state itself, which shouldn't be difficult?

# class OnsenRouter = _backboneMetal2.default.Class.extend(_backbone2.default.Router.prototype, _backbone2.default.Router).extend({
#   constructor: ->
#     @listenTo _backbone2.default.history, 'route', @_onHistoryRoute
#     @_super.apply this, arguments
#     return

#   isActive: ->
#     ! !@_isActive

#   execute: (callback, args) ->
#     _this4 = this

#     wasInactive = !@_isActive

#     if wasInactive
#       @trigger 'before:enter', this

#     @trigger 'before:route', this

#     Promise.resolve().then(->
#       _this4._execute callback, args
#     ).then(->
#       _this4.trigger 'route', _this4
#       if wasInactive
#         _this4.trigger 'enter', _this4
#       return
#     ).catch (err) ->
#       _this4.trigger 'error', _this4, err
#       # _backbone2.default.history.trigger 'error', _this4, err
#       throw err
#       return

#   _execute: (callback, args) ->
#     _this5 = this
#     Promise.resolve().then(->
#       if Router._prevRoute instanceof Route
#         return Router._prevRoute.exit()
#       return
#     ).then ->
#       route = Router._prevRoute = callback.apply(_this5, args)
#       if route instanceof Route
#         route.router = _this5
#         return route.enter(args)
#       return

#   _onHistoryRoute: (router) ->
#     @_isActive = router == this
#     return

# }, _prevRoute: null)
