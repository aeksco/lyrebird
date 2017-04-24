# Parent Class
AbstractAppRouter = require '../modules/base/abstractAppRouter'

# Routes
DeviceListRoute = require '../modules/device/list/route'
DeviceShowRoute = require '../modules/device/show/route'

InterfaceRoute = require '../modules/interface/show/route'

# Snippet
SnippetListRoute = require '../modules/snippet/list/route'
SnippetNewRoute = require '../modules/snippet/new/route'
SnippetShowRoute = require '../modules/snippet/show/route'
SnippetEditRoute = require '../modules/snippet/edit/route'

# Password (TODO - rename to Keychain?)
ListRoute = require '../modules/password/list/route'
NewRoute = require '../modules/password/new/route'
ShowRoute = require '../modules/password/show/route'
EditRoute = require '../modules/password/edit/route'

# # # # #

class AppRouter extends AbstractAppRouter

  radioEvents:
    'router device:list': 'deviceList'
    'router device:show': 'deviceShow'
    'router interface:show': 'interfaceShow'

  deviceList: ->
    @invokeRoute(new DeviceListRoute({ container: @container }))

  deviceShow: (id) ->
    @invokeRoute(new DeviceShowRoute({ container: @container }), id)

  interfaceShow: ->
    @invokeRoute(new InterfaceRoute({ container: @container }))

# # # # #

module.exports = AppRouter
