
class DeviceShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  ui:
    isConnected: '[data-display=connection]'
    connect: '[data-click=connect]'
    disconnect: '[data-click=disconnect]'
    rssi: '[data-display=rssi]'

  modelEvents:
    'change': 'render'

  events:
    'click @ui.connect': 'connectToDevice'
    'click @ui.disconnect': 'disconnect'

  serializeData: ->
    data = super
    console.log data
    return data

  onRender: ->

    # TODO - these labels should change with a modelEvent
    # @model.isConnected()
    # .then (isConnected) => @ui.isConnected.addClass('label-success').text('CONNECTED')
    # .catch (err) => @ui.isConnected.addClass('label-danger').text('NOT CONNECTED')

    # TODO - this setInterval call should happen on the device, not in the view
    return if @setInterval
    @setInterval = true
    setInterval( =>
      @model.readRSSI()
    , 500)

  connectToDevice: ->
    @model.connect()
    .then (success) => @render()
    .catch (err) => console.log 'ERROR DISCONNECTING'

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
