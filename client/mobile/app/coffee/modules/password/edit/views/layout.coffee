PasswordForm = require '../../form/views/layout'

# # # # #

class EditPasswordLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    formRegion: '[data-region=form]'

  onRender: ->
    @formRegion.show new PasswordForm({ model: @model, type: @model.get('type') })

# # # # #

module.exports = EditPasswordLayout
