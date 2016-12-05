LayoutView  = require './views/layout'

# # # # #

# PasswordListRoute class definition
class PasswordListRoute extends require '../base/route'

  fetch: ->
    return Backbone.Radio.channel('password').request('collection')
    .then (methods) => @collection = methods

  render: (id) ->
    @container.show new LayoutView({ collection: @collection })

# # # # #

module.exports = PasswordListRoute
