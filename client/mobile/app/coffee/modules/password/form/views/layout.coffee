
class PasswordForm extends Marionette.LayoutView
  className: 'row'
  template: require './templates/form'

  behaviors:
    SubmitButton: {}

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )

  onSubmit: (e) ->
    attrs = Backbone.Syphon.serialize(@)
    console.log attrs

    Backbone.Radio.channel('password').request('collection')
    .then (collection) =>
      window.collection = collection
      console.log collection.create(attrs, {remote: false})
      console.log 'SAVE HERE'
      @onSync()

  onRequest: ->
    console.log 'ON REQUEST'

  onError: ->
    console.log 'ON ERROR'

  onSync: ->
    console.log 'ON SYNC'
    window.location = '#passwords'

# # # # #

module.exports = PasswordForm
