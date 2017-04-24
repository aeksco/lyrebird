# This file defines a manifest for Tack's client application.
# This includes configuration, Services, Components, Modules
# and the Application singleton instance

# # # # #

# Application configuration manifest
# require './config'

# Application
CordovaApp = require './cordova_app'

# Application Layout
window.Layout = require './application/layout'

# Services are routeless, viewless background workers
# We currently use a single service to manage sending SMS
# and requesting requisite permissions
BluetoothService  = require './services/bluetooth'
KnownDeviceServie = require './services/known_device'

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
HomeModule      = require './modules/home/router'
DeviceModule    = require './modules/device/router'
# DeviceService = require './modules/device/service'

# InterfaceModule = require './modules/interface/router'
# PasswordModule  = require './modules/password/router'
# SnippetModule   = require './modules/snippet/router'

# # # # # #

# # Page has loaded, document is ready
# $(document).on 'ready', => new CordovaApp()


# # # # # #

OnsenView = require './onsen_tests/view'

# Page has loaded, document is ready
# $(document).on 'ready', =>
#   console.log 'ONSEN UI START'

# // Onsen UI is now initialized
ons.ready =>
  # new CordovaApp()

  # ons.notification.alert('Welcome to Onsen UI!')

  # console.log 'NEW ONSEN VIEW'

  # NOTE - views rendered into an element (i.e. standard region.show behavior)
  # Do not require any additional configuration for event bidings
  setTimeout( =>
    view = new OnsenView({ el: '#splitContent' })
    view.render()
  , 1000)


  # However, views rendered into the application with naviagor.pushPage() do require some additional configuration
  # Figure out which views will use this, and ensure that functionality will be consistent

  # navigator = document.getElementById('myNavigator')

  # setTimeout( =>

  #   navigator.pushPage('region', { pageHTML: view.$el.html() })
  #   view.setElement(view.elName)

  # , 1000)

  # navigator = document.getElementById("myNavigator")
  # navigator.pushPage('foo', { page: view.el })

  # setTimeout( =>

  #   # TODO - this should be abstracted into a region?
  #   # navigator.pushPage('foo', { pageHTML: view.el })
  #   # console.log view.isRendered()
  #   # console.log view.isAttached()
  #   # navigator.pushPage('foo', { pageHTML: view.$el.html() })

  # , 2000 )





# # # # #
