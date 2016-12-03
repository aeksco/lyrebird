
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
    # window.Contact is only defined when the app is running
    # on a mobile device
    @onDeviceReady() unless window.ble
    return true

  # Starts the application
  # Starts Backbone.history (enables routing)
  # And initializes header and sidebar modules
  onDeviceReady: ->
    Backbone.history.start()
    Backbone.Radio.channel('sidebar').trigger('initialize')

    # TODO - abstract into header component
    $('.navbar-brand').on 'click', =>
      Backbone.Radio.channel('sidebar').trigger('toggle')

# # # # #

module.exports = CordovaApp
