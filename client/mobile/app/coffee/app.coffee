
# Application configuration manifest
require './config'

# Application & Router & Layout
CordovaApp  = require './cordova_app'
AppRouter   = require './application/router'
AppLayout   = require './onsen_tests/app_layout'

# Services
BluetoothService      = require './services/bluetooth'
# BluetoothDevService   = require './services/bluetooth_dev'
KnownDeviceServie = require './services/known_device'

# Module Services
# TODO - rename to factories?
DeviceService   = require './modules/device/service'
SnippetService  = require './modules/snippet/service'
PasswordService = require './modules/password/service'

# # # # # #

# # Page has loaded, document is ready
# $(document).on 'ready', => new CordovaApp()

# Onsen UI is now initialized
ons.ready =>
  console.log 'ONSEN READY'

  # # # # # # # # # # # # # # # # # # # #
  # # # # # # # # # # # # # # # # # # # #
  # TODO - everything below this must be abstracted


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

  # TODO - is CordovaApp still needed?
  new CordovaApp()

