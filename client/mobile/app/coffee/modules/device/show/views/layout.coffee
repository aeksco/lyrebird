
class DeviceShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  ui:
    isConnected: '[data-display=connection]'
    connect: '[data-click=connect]'
    disconnect: '[data-click=disconnect]'
    rssi: '[data-display=rssi]'

  events:
    'click @ui.connect': 'connectToDevice'

  onRender: ->

    # TODO - these labels should change with a modelEvent
    @model.isConnected()
    .then (isConnected) => @ui.isConnected.addClass('label-success').text('CONNECTED')
    .catch (err) => @ui.isConnected.addClass('label-danger').text('NOT CONNECTED')

    # TODO - this setInterval call should happen on the device, not in the view
    return if @setInterval
    @setInterval = true
    setInterval( =>
      @model.readRSSI()
      .then (dev) => @ui.rssi.text('RSSI: ' + dev)
      .catch (err) => console.log err
    , 500)

  connectToDevice: ->
    console.log 'CONNECT TO DEVICE'
    console.log @model

    @model.connect()
    .then (success) =>
      console.log 'Connected?'
      console.log success
      @render()

    .catch (err) =>
      console.log 'CONNECTION ERROR'
      console.log err

    #   @model.disconnect()
    #   .then (success) =>
    #     console.log 'disconnected?'
    #     console.log success

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    data

# # # # #

module.exports = DeviceShowLayout
