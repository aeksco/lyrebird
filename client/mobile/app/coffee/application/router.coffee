# Parent Class
AbstractAppRouter = require '../modules/base/abstractAppRouter'

# Routes
Main =
  Autoconnect: require '../modules/home/home/route'

# Device
Device =
  List: require '../modules/device/list/route'
  Show: require '../modules/device/show/route'

Interface =
  Show: require '../modules/interface/show/route'

# Snippet
Snippet =
  List: require '../modules/snippet/list/route'
  New:  require '../modules/snippet/new/route'
  Show: require '../modules/snippet/show/route'
  Edit: require '../modules/snippet/edit/route'

# Password (TODO - rename to Keychain?)
Password =
  List: require '../modules/password/list/route'
  New:  require '../modules/password/new/route'
  Show: require '../modules/password/show/route'
  Edit: require '../modules/password/edit/route'

# # # # #

# NOTE - this could be split into module-specific routers, if necessary
class AppRouter extends AbstractAppRouter

  radioEvents:

    # Home
    'router main:autoconnect': 'mainAutoconnect'

    # Device
    'router device:list': 'deviceList'
    'router device:show': 'deviceShow'

    # Interface
    'router interface:show': 'interfaceShow'

    # Snippet
    'router snippet:list':  'snippetList'
    'router snippet:new':   'snippetNew'
    'router snippet:show':  'snippetShow'
    'router snippet:edit':  'snippetEdit'

    # Password
    'router password:list': 'passwordList'
    'router password:new':  'passwordNew'
    'router password:show': 'passwordShow'
    'router password:edit': 'passwordEdit'

  # Main
  mainAutoconnect: ->
    console.log 'AUTO CONNECT??'
    @invokeRoute(new Main.Autoconnect({ container: @container }))

  # Device
  deviceList: ->
    @invokeRoute(new Device.List({ container: @container }))

  deviceShow: (id) ->
    @invokeRoute(new Device.Show({ container: @container }), id)

  # Interface
  interfaceShow: ->
    @invokeRoute(new Interface.Show({ container: @container }))

  # Snippet
  snippetList: ->
    @invokeRoute(new Snippet.List({ container: @container }))

  snippetNew: ->
    @invokeRoute(new Snippet.New({ container: @container }))

  snippetShow: (id) ->
    @invokeRoute(new Snippet.Show({ container: @container }), id)

  snippetEdit: (id) ->
    @invokeRoute(new Snippet.Edit({ container: @container }), id)

  # Password
  passwordList: ->
    @invokeRoute(new Password.List({ container: @container }))

  passwordNew: ->
    @invokeRoute(new Password.New({ container: @container }))

  passwordShow: (id) ->
    @invokeRoute(new Password.Show({ container: @container }), id)

  passwordEdit: (id) ->
    @invokeRoute(new Password.Edit({ container: @container }), id)

# # # # #

module.exports = AppRouter
