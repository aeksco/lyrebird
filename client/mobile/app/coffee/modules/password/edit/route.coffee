LayoutView  = require './views/layout'

# # # # #

class PasswordEditRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: (id) ->
    return Backbone.Radio.channel('password').request('model', id)
    .then (model) => @model = model

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = PasswordEditRoute
