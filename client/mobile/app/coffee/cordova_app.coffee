
# TODO - document this application, shift into a Marionette.Service?
class CordovaApp

  constructor: ->
    @initialize()

  initialize: ->
    return @bindEvents()

  bindEvents: ->
    onDeviceReadyCallback = -> Backbone.history.start()
    document.addEventListener 'deviceready', onDeviceReadyCallback, false

  # onDeviceReady: ->
  #   console.log 'Device ready - list Bluetooth devices.'

  #   # https://github.com/apache/cordova-plugin-contacts
  #   # console.log navigator.contacts

  # receivedEvent: (id) ->
  #   console.log 'Received event: ', id

# # # # #

module.exports = CordovaApp
