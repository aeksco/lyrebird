# TODO - window configuration?
# window.Promise = require 'bluebird'
# window.$ = window.jQuery = require 'jquery'

# TODO -  Marionette configuration
# Marionette = require 'backbone.marionette'
Marionette.Behaviors.behaviorsLookup = -> require './behaviors'

# # # # #

# TODO - move elsewhere
window.Container = require './config/layout'
window.LoadingView = require './views/loading'

# # # # #

# Modules
HomeModule = require './modules/home/router'
DeviceModule = require './modules/device/router'

# Services
UsbService = require './services/usb'

# Dev tools
gui = window.require('nw.gui')
gui.Window.get().showDevTools()

# # # # #

# console.log('MEH')
$(document).on 'ready', =>
  console.log 'Document Ready'
  Backbone.history.start()
