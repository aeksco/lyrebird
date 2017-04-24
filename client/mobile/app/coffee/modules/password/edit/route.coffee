LayoutView  = require './views/layout'

# # # # #

# PasswordEditRoute class definition
class PasswordEditRoute extends require '../../base/route'

  fetch: (id) ->
    return Backbone.Radio.channel('password').request('model', id)
    .then (model) => @model = model

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = PasswordEditRoute
