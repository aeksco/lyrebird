# This file defines a manifest for Tack's client application.
# This includes configuration, Services, Components, Modules
# and the Application singleton instance

# # # # #

# Application configuration manifest
# require './config'

# Application
CordovaApp = require './cordova_app'

# Application Layout
window.Layout = require './application/layout' # TODO - decomission this view
AppRouter = require './application/router'
AppLayout = require './onsen_tests/app_layout'

# Services are routeless, viewless background workers
# We currently use a single service to manage sending SMS
# and requesting requisite permissions
# BluetoothService      = require './services/bluetooth'
BluetoothDevService   = require './services/bluetooth_dev'
KnownDeviceServie = require './services/known_device'

# TODO - all of these components can be phased out, methinks
# # Components are routeless services with views that are
# # accessible anywhere in the application
# # Used to manage the header, sidebar, flash, and confirm UI elements
# SidebarComponent  = require './components/sidebar/component'
# FlashComponent    = require './components/flash/component'
# OverlayComponent  = require './components/overlay/component'
# ConfirmComponents = require './components/confirm/component'

# Modules represent collections of endpoints in the application.
# They have routes and entities (models and collections)
# Each route represents an endpoint, or 'page' in the app.

# TODO - routers should get phased out
# Modules should only really only expose factories
HomeModule      = require './modules/home/router'
DeviceModule    = require './modules/device/router'
InterfaceModule = require './modules/interface/router'
# PasswordModule  = require './modules/password/router'
# SnippetModule   = require './modules/snippet/router'

# # # # # #

# # Page has loaded, document is ready
# $(document).on 'ready', => new CordovaApp()

# # # # # #

# // Onsen UI is now initialized
ons.ready =>

  console.log 'ONSEN UI READY'

  # TODO - is CordovaApp still needed?
  new CordovaApp()

  # TODO - rename window.fn to window.App
  # Use for things like loadPage, hide/show menu?
  window.fn = {}

  # TODO - this should be attached to the Application class instance
  window.fn.open = ->
    menu = document.getElementById('menu')
    menu.open()
    return

  # # # # #

  # TODO - this should be attached to the Application class instance
  window.fn.loadPage = (page, args...) ->
    return Backbone.Radio.channel('router').trigger(page, args)

  # # # # # #

  # Initializes AppLayout, handles page loading
  # TODO - this should be attached to the Application class instance (and it should be cleaned up a lot!)
  window.fn.load = (page, id) ->

    if window.AppLayout

      console.log 'LOAG PAGE'
      window.fn.loadPage(page, id)

    else

      # TODO - this needs to be managed as part of the application lifecycle
      console.log 'INIT LAYOUT VIEW'
      window.AppLayout = new AppLayout({ el: '#content' })

      new AppRouter({ container: window.AppLayout.layoutRegion })

      # AppLayout has been rendered - app is now ready for views to be inserted in
      window.AppLayout.on 'render', =>

        console.log 'LAYOUT RENDERED'

        # Loads the selected page
        window.fn.loadPage(page, id)

      # Renders AppLayout
      window.AppLayout.render()

    return

  # # # # #
