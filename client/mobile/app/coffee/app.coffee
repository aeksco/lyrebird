require './hammer-time.min' # TODO - should be node module
window.Promise = require 'bluebird'

# # # # #

# Marionette behaviors configuration
Marionette.Behaviors.behaviorsLookup = -> require './behaviors'

# # # # #

# Cordova app & configuration
# CordovaApp = require './cordova_app'
window.Container = require './config/layout'
window.LoadingView = require './views/loading'

# # # # #

# Modules
HomeModule = require './modules/home/router'
DeviceModule = require './modules/device/router'
InterfaceModule = require './modules/interface/router'

# Services
BluetoothService = require './services/bluetooth'

# # # # #

$(document).on 'ready', =>
  console.log 'Document Ready'
  Backbone.history.start()

  # # # # #
  # TODO - abstract elsewhere
  $('.navbar-brand').on 'click', ->
    for nav in $('.nav-item')
      $(nav).find('.nav-link').removeClass('active')

  $('.nav-item').on 'click', ->
    $(@).find('.nav-link').addClass('active')

    for nav in $(@).siblings('.nav-item')
      $(nav).find('.nav-link').removeClass('active')
  #
  # # # # #
