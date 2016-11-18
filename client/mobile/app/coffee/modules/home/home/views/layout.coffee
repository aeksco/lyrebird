
# # # # #

class AutoConnectView extends Marionette.LayoutView
  template: require './templates/auto_connect'
  className: 'row'

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
    return if @model.get('connected')
    @model.connect()

# # # # #

class HomeLayoutView extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

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
    @statusRegion.show new AutoConnectView({ model: @foundDevice })

# # # # #

module.exports = HomeLayoutView
