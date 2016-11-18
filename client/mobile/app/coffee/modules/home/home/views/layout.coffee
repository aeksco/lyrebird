
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
    console.log 'CONNECT TO DEVICE!'
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
    @foundDevice = @collection.get(@model.id)

    # Return if device hasn't been found
    return if not @foundDevice

    #
    @render()

  onRender: ->
    @statusRegion.show new AutoConnectView({ model: @foundDevice })

  # initialize: ->
  #   @startPolling()

  # onDestroy: ->
  #   @stopPolling()

  # startPolling: ->
  #   return if @interval
  #   @interval = setInterval( @scanForDevices, 10000 )

  # stopPolling: ->
  #   return unless @interval
  #   clearInterval(@interval)
  #   delete @interval

  # scanForDevices: ->
  #   Backbone.Radio.channel('device').request('collection')

# # # # #

module.exports = HomeLayoutView
