
class PasswordCollection extends Backbone.Collection
  model: require './model'
  url: '/passwords' # TODO - this is a local collection ONLY

# # # # #

module.exports = PasswordCollection
