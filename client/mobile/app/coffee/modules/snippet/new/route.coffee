LayoutView  = require './views/layout'

# # # # #

# SnippetNewRoute class definition
class SnippetNewRoute extends require '../base/route'

  fetch: ->
    return Backbone.Radio.channel('snippet').request('model')
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = SnippetNewRoute
