PasswordForm = require '../../form/views/layout'

# # # # #

class NewPasswordLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    formRegion: '[data-region=form]'

  ui:
    typeButton: '[data-click=type]'

  events:
    'click @ui.typeButton': 'changeFormType'

  showForm: (type) ->
    @formRegion.show new PasswordForm({ model: @model, type: type })

  changeFormType: (e) ->
    el = @$(e.currentTarget)
    el.addClass('active').siblings('.btn').removeClass('active')
    type = el.data('form')
    @showForm(type)

  onRender: ->
    @showForm('email')

# # # # #

module.exports = NewPasswordLayout
