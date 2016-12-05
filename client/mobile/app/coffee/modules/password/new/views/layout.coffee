PasswordForm = require '../../form/views/layout'

# # # # #

# NewPasswordLayout class definition
# Defines a Marionette.LayoutView that acts as a wrapper
# to the PasswordForm defined in an outside file
class NewPasswordLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    formRegion: '[data-region=form]'

  onRender: ->
    @formRegion.show new PasswordForm({ model: @model, type: type })

# # # # #

module.exports = NewPasswordLayout
