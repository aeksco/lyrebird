LayoutView  = require './views/layout'

# # # # #

# PasswordShowRoute class definition
class PasswordShowRoute extends require '../../base/route'

  fetch: (id) ->
    return Backbone.Radio.channel('password').request('model', id)
    .then (method) => @model = method

  render: (id) ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = PasswordShowRoute
