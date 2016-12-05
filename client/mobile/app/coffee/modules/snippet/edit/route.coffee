LayoutView  = require './views/layout'

# # # # #

# SnippetEditRoute class definition
class SnippetEditRoute extends require '../base/route'

  fetch: (id) ->
    return Backbone.Radio.channel('snippet').request('model', id)
    .then (model) => @model = model

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = SnippetEditRoute
