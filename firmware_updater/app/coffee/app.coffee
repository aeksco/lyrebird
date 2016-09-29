window.Promise = require 'bluebird'

Marionette = require 'backbone.marionette'

# # # # #

# Marionette behaviors configuration
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

  # lb = '<br><br>'

  # Backbone.Radio.channel('usb').request('devices')
  # .then (devices) =>
  #   $('body').append('GOT USB DEVICES\n')
  #   $('body').append(lb)

  #   for d in devices
  #     $('body').append( JSON.stringify(d, null, 2) )
  #     $('body').append(lb)
