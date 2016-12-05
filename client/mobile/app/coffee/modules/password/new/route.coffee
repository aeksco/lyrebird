LayoutView  = require './views/layout'

# # # # #

# PasswordNewRoute class definition
class PasswordNewRoute extends require '../base/route'

  fetch: ->
    return Backbone.Radio.channel('password').request('model')
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = PasswordNewRoute
