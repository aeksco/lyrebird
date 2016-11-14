
class PasswordForm extends Marionette.LayoutView
  className: 'row'

  # template: => # TODO - template

  # behaviors:
  #   ModelEvents: {}
  #   SubmitButton: {}

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )

  onSubmit: (e) ->
    attrs = Backbone.Syphon.serialize(@)
    @model.save(attrs)

  onRequest: ->
    console.log 'ON REQUEST'

  onError: ->
    console.log 'ON ERROR'

  onSync: ->
    console.log 'ON SYNC'
    window.location = '#passwords'

# # # # #

module.exports = PasswordForm
