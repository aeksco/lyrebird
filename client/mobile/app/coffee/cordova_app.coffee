
# CordovaApp class definition
# Manages lifecycle and bootstraps application
# mobile device on which the app is running
class CordovaApp extends Marionette.Service

  initialize: ->

    # Listener for 'deviceready' event
    # fired when the Cordova framework has successfully initialized
    document.addEventListener 'deviceready', @onDeviceReady, false

    # Starts application without 'deviceready' event
    # Used while debugging the application in-browser
    # window.ble is only defined when the app is running
    # on a mobile device
    setTimeout( =>
      @onDeviceReady() unless window.ble
    , 1000)

    return true

  # Starts the application
  # Starts Backbone.history (enables routing)
  # And initializes header and sidebar modules
  onDeviceReady: ->
    console.log 'STARTED CORDOVA APP'
    Backbone.history.start()

# # # # #

module.exports = CordovaApp
