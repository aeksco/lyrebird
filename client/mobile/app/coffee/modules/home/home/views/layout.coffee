
# # # # #

# AutoConnectView class definition
# Defines a Marionette.LayoutView that manages auto-connecting
# to a KnownDevice when one is detected. This view manages status updates
# during the auto-connection routine.
class AutoConnectView extends Marionette.LayoutView
  template: require './templates/auto_connect'
  # className: 'row'
  tagName: 'ons-row'

  statuses:
    searching:  'Searching for devices...'
    connecting: 'Connecting to device...'
    connected:  'Connected to Lyrebird.'

  modelEvents:
    'change': 'render'

  getStatus: ->
    return 'searching'  if not @model
    return 'connected'  if @model.get('connected')
    return 'connecting'

  serializeData: ->
    status = @getStatus()
    return { status: status, message: @statuses[status] }

  onRender: ->
    return unless @model
    return setTimeout( @routeOnConnected, 1000 ) if @model.get('connected')
    @model.connect()

  routeOnConnected: ->
    route = localStorage.lastRoute || '#interface?type=keyboard'
    window.location = route
    return

# # # # #

# HomeLayoutView class definition
# Defines a Marionette.LayoutView that manages the auto-connect view.
# This view will likely get merged with the device list view in a later build.
class HomeLayoutView extends Marionette.LayoutView
  template: require './templates/layout'
  # className: 'container-fluid'

  tagName: 'ons-template'
  elName: '#autoConnect'

  collectionEvents:
    'add': 'connectIfKnown'

  regions:
    statusRegion: '[data-region=status]'

  connectIfKnown: ->

    # Return if no known devices are found
    return unless @model

    # Finds known device model
    @foundDevice = @collection.get(@model.id)

    # Return if device hasn't been found
    return if not @foundDevice
    @render()

  onRender: ->
    console.log 'RENDERED'
    console.log @foundDevice
    @statusRegion.show new AutoConnectView({ model: @foundDevice })

# # # # #

module.exports = HomeLayoutView
