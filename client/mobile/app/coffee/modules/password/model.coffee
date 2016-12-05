
# PasswordModel class definition
# Defines a Backbone.Model class used by the PasswordCollection & PasswordService
class PasswordModel extends Backbone.Model
  urlRoot: '/passwords/'

# # # # #

module.exports = PasswordModel
