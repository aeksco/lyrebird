
# PasswordForm class definition
# Defines a Marionette.LayoutView class for collecting
# parameters used to create or update a PasswordModel

# This view is a work in progress, much like the rest of the PasswordModule
class PasswordForm extends Marionette.LayoutView
  className: 'row'
  template: require './templates/form'

  behaviors:
    SubmitButton: {}

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )

  onSubmit: (e) ->
    attrs = Backbone.Syphon.serialize(@)

    Backbone.Radio.channel('password').request('collection')
    .then (collection) =>

      # CryptoJS - Encrypt
      ciphertext = CryptoJS.AES.encrypt(attrs.password, attrs.pin)

      # Save encrypted password
      save_attrs = { label: attrs.label, password: ciphertext.toString() }
      collection.create(save_attrs, {remote: false})

      # TODO - Decrypt
      # bytes  = CryptoJS.AES.decrypt(ciphertext.toString(), 'secret key 123')
      # plaintext = bytes.toString(CryptoJS.enc.Utf8)
      # console.log plaintext

      # Invokes onSync callback
      @onSync()

  onError: ->
    console.log 'ON ERROR'

  onSync: ->
    window.location = '#passwords'

# # # # #

module.exports = PasswordForm
