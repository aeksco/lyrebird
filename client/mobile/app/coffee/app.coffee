
# Application configuration
require './config'

# Cordova app & configuration
CordovaApp = require './cordova_app'

# Application Layout
# TODO - get rid of references to 'window.X'
AppLayout = require './application/layout'
window.Container = AppLayout.main
window.SidebarContainer = AppLayout.sidebar
window.FlashContainer = AppLayout.flash

# Services
BluetoothService = require './services/bluetooth'
KnownDeviceServie = require './modules/known_device/storage'

# Components
SidebarComponent = require './modules/sidebar/component'
FlashComponent = require './modules/flash/component'

# Modules
HomeModule      = require './modules/home/router'
DeviceModule    = require './modules/device/router'
InterfaceModule = require './modules/interface/router'
PasswordModule  = require './modules/password/router'
SnippetModule   = require './modules/snippet/router'

# # # # #

$(document).on 'ready', =>
  console.log 'Document Ready'

  # Backbone.history.start() Invoked inside CordovaApp
  new CordovaApp()
  # Backbone.history.start() # DEBUG ONLY

  # TODO - abstract elsewhere
  Backbone.Radio.channel('sidebar').trigger('initialize')

  # TODO - abstract into header component
  $('.navbar-brand').on 'click', =>
    Backbone.Radio.channel('sidebar').trigger('toggle')
