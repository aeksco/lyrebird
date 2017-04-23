# This file defines a manifest for Tack's client application.
# This includes configuration, Services, Components, Modules
# and the Application singleton instance

# # # # #

# Application configuration manifest
# require './config'

# # Application
# CordovaApp = require './cordova_app'

# # Application Layout
# window.Layout = require './application/layout'

# # Services are routeless, viewless background workers
# # We currently use a single service to manage sending SMS
# # and requesting requisite permissions
# BluetoothService  = require './services/bluetooth'
# KnownDeviceServie = require './services/known_device'

# # Components are routeless services with views that are
# # accessible anywhere in the application
# # Used to manage the header, sidebar, flash, and confirm UI elements
# SidebarComponent  = require './components/sidebar/component'
# FlashComponent    = require './components/flash/component'
# OverlayComponent  = require './components/overlay/component'
# ConfirmComponents = require './components/confirm/component'

# # Modules represent collections of endpoints in the application.
# # They have routes and entities (models and collections)
# # Each route represents an endpoint, or 'page' in the app.
# HomeModule      = require './modules/home/router'
# DeviceModule    = require './modules/device/router'
# InterfaceModule = require './modules/interface/router'
# PasswordModule  = require './modules/password/router'
# SnippetModule   = require './modules/snippet/router'

# # # # # #

# # Page has loaded, document is ready
# $(document).on 'ready', => new CordovaApp()


# # # # # #

# Page has loaded, document is ready
# $(document).on 'ready', =>
#   console.log 'ONSEN UI START'

ons.ready =>
  # // Onsen UI is now initialized
  ons.notification.alert('Welcome to Onsen UI!')
