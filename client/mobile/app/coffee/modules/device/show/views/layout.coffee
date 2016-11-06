
class RSSIView extends Marionette.LayoutView
  template: require './templates/rssi'
  className: 'label label-primary'
  tagName: 'span'

  modelEvents:
    'change': 'render'

  onRender: ->
    console.log 'RENDERED RSSI'

    # TODO - this setInterval call should happen on the device, not in the view
    # TODO - abstract this into the model, set timeout there

    # @model.isConnected()
    # .then (isConnected) =>

    #   return if @setInterval

    #   @setInterval = true

    #   setInterval( =>
    #     @model.readRSSI()
    #   , 500)

    # .catch (err) =>
    #   console.log 'CONNECTION ERROR'

# # # # #

class ControlsView extends Marionette.LayoutView
  template: require './templates/controls'
  className: 'row'

  ui:
    connect: '[data-click=connect]'
    disconnect: '[data-click=disconnect]'

  events:
    'click @ui.connect': 'connect'
    'click @ui.disconnect': 'disconnect'

  onRender: ->
    # TODO - these labels should change with a modelEvent
    # @model.isConnected()
    # .then (isConnected) => @ui.isConnected.addClass('label-success').text('CONNECTED')
    # .catch (err) => @ui.isConnected.addClass('label-danger').text('NOT CONNECTED')

  connect: ->
    @model.connect()
    .then (success) => @render()
    .catch (err) => console.log 'ERROR CONNECTING'

  disconnect: ->
    @model.disconnect()
    .then () => @render()
    .catch () -> console.log 'ERROR DISCONNECTING'

# # # # #

class DeviceShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    rssiRegion: '[data-region=rssi]'
    controlsRegion: '[data-region=controls]'

  onRender: ->
    @rssiRegion.show new RSSIView({ model: @model })
    @controlsRegion.show new ControlsView({ model: @model })

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    data

# # # # #

module.exports = DeviceShowLayout
