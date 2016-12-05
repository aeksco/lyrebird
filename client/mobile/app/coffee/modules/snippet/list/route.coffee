LayoutView  = require './views/layout'

# # # # #

# SnippetListRoute class definition
class SnippetListRoute extends require '../base/route'

  fetch: ->
    return Backbone.Radio.channel('snippet').request('collection')
    .then (methods) => @collection = methods

  render: (id) ->
    @container.show new LayoutView({ collection: @collection })

# # # # #

module.exports = SnippetListRoute
