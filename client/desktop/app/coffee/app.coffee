window.Promise = require 'bluebird'

# # # # #

# Marionette behaviors configuration
Marionette = require 'backbone.marionette'
Marionette.Behaviors.behaviorsLookup = -> require './behaviors'

# # # # #

# Window configuration
window.Container = require './config/layout'
window.LoadingView = require './views/loading'

# # # # #

# Modules
HomeModule = require './modules/home/router'
DeviceModule = require './modules/device/router'

# Services
UsbService = require './services/usb'

# Dev tools
# gui = window.require('nw.gui')
# gui.Window.get().showDevTools()

# # # # #

$(document).on 'ready', =>
  console.log 'Document Ready'
  Backbone.history.start()
