
class DeviceShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  ui:
    connect: '[data-click=connect]'

  events:
    'click @ui.connect': 'connectToDevice'

  connectToDevice: ->
    console.log 'CONNECT TO DEVICE'
    console.log @model

    @model.isConnected()
    .then (isConnected) =>
      console.log 'isConnected?'
      console.log isConnected

    #   # @model.connect()
    #   # .then (success) =>
    #   #   console.log 'Connected?'
    #   #   console.log success
    #   #   console.log

    #   #   @model.disconnect()
    #   #   .then (success) =>
    #   #     console.log 'disconnected?'
    #   #     console.log success

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    data

# # # # #

module.exports = DeviceShowLayout
