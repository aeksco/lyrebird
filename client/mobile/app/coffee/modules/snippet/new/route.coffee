LayoutView  = require './views/layout'

# # # # #

class SnippetNewRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: ->
    return Backbone.Radio.channel('snippet').request('model')
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = SnippetNewRoute
