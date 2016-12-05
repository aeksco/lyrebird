PasswordForm = require '../../form/views/layout'

# # # # #

# EditPasswordLayout class definition
# Defines a Marionette.LayoutView that acts as a wrapper
# to the PasswordForm defined in an outside file
class EditPasswordLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    formRegion: '[data-region=form]'

  onRender: ->
    @formRegion.show new PasswordForm({ model: @model, type: @model.get('type') })

# # # # #

module.exports = EditPasswordLayout
