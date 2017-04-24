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
AppRouter = require './application/router'

# Services are routeless, viewless background workers
# We currently use a single service to manage sending SMS
# and requesting requisite permissions
# BluetoothService      = require './services/bluetooth'
BluetoothDevService   = require './services/bluetooth_dev'
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
DeviceListRoute = require './modules/device/list/route'
DeviceService = require './modules/device/service'

InterfaceModule = require './modules/interface/router'
# PasswordModule  = require './modules/password/router'
# SnippetModule   = require './modules/snippet/router'

# # # # # #

# # Page has loaded, document is ready
# $(document).on 'ready', => new CordovaApp()

# # # # # #

LayoutView = require './onsen_tests/view'
CollectionView = require './onsen_tests/collectionView'

models = [
  { name: 'Alex' }
  { name: 'Alaina' }
  { name: 'Django' }
]

# models = []
collection = new Backbone.Collection(models)
# # # # #

AppLayout = require './onsen_tests/app_layout'

# # # # #

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

  # TODO - remove - this has been abstracted
  window.fn.showView = (view) ->
    menu = document.getElementById('menu')
    view.on 'render', => menu.close()
    window.AppLayout.layoutRegion.show(view)

  # # # # #

  # TODO - this should be attached to the Application class instance
  window.fn.loadPage = (page, id) ->

    # Cache menu
    menu = document.getElementById('menu')

    # Testing Mn.CollectionView + Events
    if page == 'keychain.html'

      view = new LayoutView()
      return window.fn.showView(view)

    if page == 'snippets.html'

      view = new CollectionView({ collection: collection })
      return window.fn.showView(view)

    # TODO - all pages should function this way
    if page == 'device:list' || page == 'device:show'
      return Backbone.Radio.channel('router').trigger(page, id)

    else

      console.log 'NOT BACKBONE VIEW'
      # Static view?
      # content = document.getElementById('content')
      # menu = document.getElementById('menu')
      # content.load(page).then menu.close.bind(menu)

    return

  # # # # # #

  # Initializes AppLayout, handles page loading
  # TODO - this should be attached to the Application class instance
  window.fn.load = (page, id) ->

    if window.AppLayout

      console.log 'LOAG PAGE'
      window.fn.loadPage(page, id)

    else

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
