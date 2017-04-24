LayoutView  = require './views/layout'

# # # # #

# SnippetShowRoute class definition
class SnippetShowRoute extends require '../../base/route'

  fetch: (id) ->
    return Backbone.Radio.channel('snippet').request('model', id)
    .then (method) => @model = method

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = SnippetShowRoute
