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
