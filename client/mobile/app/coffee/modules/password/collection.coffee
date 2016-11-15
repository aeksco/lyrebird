
class PasswordCollection extends Backbone.Collection
  url: '/passwords/'
  model: require './model'
  local: true  # Backbone.DualStorage configuration

# # # # #

module.exports = PasswordCollection
