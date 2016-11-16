LayoutView  = require './views/layout'

# # # # #

class PasswordShowRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: (id) ->
    return Backbone.Radio.channel('password').request('model', id)
    .then (method) => @model = method

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = PasswordShowRoute
