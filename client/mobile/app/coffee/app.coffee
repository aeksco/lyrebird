
# Application configuration
require './config'

# Cordova app & configuration
CordovaApp = require './cordova_app'

# Application Layout
AppLayout = require './application/layout'
window.Layout = AppLayout

# TODO - remove these references
window.Container = AppLayout.main
window.SidebarContainer = AppLayout.sidebar
window.FlashContainer = AppLayout.flash

# Services
BluetoothService  = require './services/bluetooth'
KnownDeviceServie = require './services/known_device'

# Components
SidebarComponent  = require './components/sidebar/component'
FlashComponent    = require './components/flash/component'
OverlayComponent  = require './components/overlay/component'
ConfirmComponents = require './components/confirm/component'

# Modules
HomeModule      = require './modules/home/router'
DeviceModule    = require './modules/device/router'
InterfaceModule = require './modules/interface/router'
PasswordModule  = require './modules/password/router'
SnippetModule   = require './modules/snippet/router'

# # # # #

$(document).on 'ready', =>
  console.log 'Document Ready'

  # Stars app & lifecycle
  new CordovaApp()
