LayoutView  = require './views/layout'

# # # # #

class PasswordListRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: ->
    return Backbone.Radio.channel('password').request('collection')
    .then (methods) => @collection = methods

  render: (id) ->
    @container.show new LayoutView({ collection: @collection })

# # # # #

module.exports = PasswordListRoute
