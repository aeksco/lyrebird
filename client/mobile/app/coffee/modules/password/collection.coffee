
class PasswordCollection extends Backbone.Collection
  model: require './model'
  local: true  # Backbone.DualStorage configuration

# # # # #

module.exports = PasswordCollection
