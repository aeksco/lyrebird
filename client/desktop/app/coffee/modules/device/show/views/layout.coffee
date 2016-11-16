
class DeviceShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  events:
    'click [data-click=connect]': 'connect'
    'click [data-click=disconnect]': 'disconnect'
    'click [data-click=load-firmware]': 'loadFirmware'

  modelEvents:
    'change': 'render'

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    data

  connect: ->
    @model.open()
    .then () =>
      @model.claim()
      .then () =>
        console.log 'Opened & Claimed'

  disconnect: ->
    @model.disconnect()

  loadFirmware: ->
    @model.loadFirmware()

# # # # #

module.exports = DeviceShowLayout
