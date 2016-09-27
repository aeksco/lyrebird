
class CordovaApp

  constructor: ->
    console.log 'constructor'
    @initialize()

  initialize: ->
    console.log 'initialize'
    @bindEvents()
    return

  bindEvents: ->
    console.log 'bindEvents'

    # onDeviceReadyCallback = ->
    #   console.log 'ON DEVICE READY!!'

    # document.addEventListener 'deviceready', onDeviceReadyCallback, false

  # onDeviceReady: ->
  #   console.log 'Device ready - list contacts.'

  #   # https://github.com/apache/cordova-plugin-contacts
  #   # console.log navigator.contacts

  # receivedEvent: (id) ->
  #   console.log 'Received event: ', id

# # # # #

module.exports = CordovaApp
