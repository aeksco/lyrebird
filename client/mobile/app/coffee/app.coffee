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
# BluetoothService  = require './services/bluetooth_dev'
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

  window.fn.open = ->
    menu = document.getElementById('menu')
    menu.open()
    return

  # # # # #

  # TODO - this should be an AbstractController method
  window.fn.showView = (view) ->
    menu = document.getElementById('menu')
    view.on 'render', => menu.close()
    window.AppLayout.layoutRegion.show(view)

  # # # # #

  # TODO - there should be an object that maps
  # pageName: ControllerInstance
  window.fn.loadPage = (page) ->

    # Cache menu
    menu = document.getElementById('menu')

    # Testing Mn.CollectionView + Events
    if page == 'keychain.html'

      view = new LayoutView()
      window.fn.showView(view)

    if page == 'snippets.html'

      view = new CollectionView({ collection: collection })
      window.fn.showView(view)

    else

      console.log 'NOT BACKBONE VIEW'
      # Static view?
      # content = document.getElementById('content')
      # menu = document.getElementById('menu')
      # content.load(page).then menu.close.bind(menu)

    return

  # # # # # #

  # Initializes AppLayout, handles page loading
  window.fn.load = (page) ->

    if window.AppLayout

      console.log 'LOAG PAGE'
      window.fn.loadPage(page)

    else

      console.log 'INIT LAYOUT VIEW'
      window.AppLayout = new AppLayout({ el: '#content' })

      # AppLayout has been rendered - app is now ready for views to be inserted in
      window.AppLayout.on 'render', =>

        console.log 'LAYOUT RENDERED'

        # Loads the selected page
        window.fn.loadPage(page)

      # Renders AppLayout
      window.AppLayout.render()

    return

  # # # # #


  # TODO - navigator
  # ons.notification.alert('Welcome to Onsen UI!')

  # console.log 'NEW ONSEN VIEW'

  # NOTE - views rendered into an element (i.e. standard region.show behavior)
  # Do not require any additional configuration for event bidings
  # setTimeout( =>
  #   view = new OnsenView({ el: '#splitContent' })
  #   view.render()
  # , 1000)


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

# Page has loaded, document is ready
# $(document).on 'ready', =>
#   console.log 'ONSEN UI START'

# TODO - bluetooth service mock should return array of:
# {
# id:     "04:A3:16:0A:66:4A"
# known:  false
# name:   "Lyrebird"
# rssi:   -75
# }

# # # # #
