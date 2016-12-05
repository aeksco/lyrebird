
# PasswordShowLayout class definition
# Defines a Marionette.LayoutView class to display a Password
# Includes controls to Edit & Destroy the Password (TODO)
class PasswordShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  # TODO - destroy Password

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    return data

# # # # #

module.exports = PasswordShowLayout
