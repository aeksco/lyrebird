LayoutView  = require './views/layout'

# # # # #

class SnippetListRoute extends Backbone.Routing.Route

  initialize: (options={}) ->
    @container = options.container

  fetch: ->
    return Backbone.Radio.channel('snippet').request('collection')
    .then (methods) => @collection = methods

  render: (id) ->
    @container.show new LayoutView({ collection: @collection })

# # # # #

module.exports = SnippetListRoute
