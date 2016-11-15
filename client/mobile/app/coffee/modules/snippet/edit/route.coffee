LayoutView  = require './views/layout'

# # # # #

class SnippetEditRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: (id) ->
    return Backbone.Radio.channel('snippet').request('model', id)
    .then (model) => @model = model

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = SnippetEditRoute
