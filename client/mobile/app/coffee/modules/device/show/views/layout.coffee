
class RSSIView extends Marionette.LayoutView
  template: require './templates/rssi'
  className: 'label label-primary'
  tagName: 'span'

  modelEvents:
    'change': 'render'

  onRender: ->
    # TODO - this setInterval call should happen on the device, not in the view
    # TODO - abstract this into the model, set timeout there
    console.log 'RENDERED RSSI VIEw'
    return if @setInterval
    @setInterval = true
    setInterval( =>
      @model.readRSSI()
    , 500)

# # # # #

class DeviceShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    rssiRegion: '[data-region=rssi]'

  ui:
    isConnected: '[data-display=connection]'
    connect: '[data-click=connect]'
    disconnect: '[data-click=disconnect]'

  events:
    'click @ui.connect': 'connectToDevice'
    'click @ui.disconnect': 'disconnect'

  serializeData: ->
    data = super
    return data

  onRender: ->
    @rssiRegion.show new RSSIView({ model: @model })

    # TODO - these labels should change with a modelEvent
    # @model.isConnected()
    # .then (isConnected) => @ui.isConnected.addClass('label-success').text('CONNECTED')
    # .catch (err) => @ui.isConnected.addClass('label-danger').text('NOT CONNECTED')

  connectToDevice: ->
    @model.connect()
    .then (success) => @render()
    .catch (err) => console.log 'ERROR CONNECTING'

  disconnect: ->
    @model.disconnect()
    .then () => @render()
    .catch () -> console.log 'ERROR DISCONNECTING'


  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    data

# # # # #

module.exports = DeviceShowLayout
