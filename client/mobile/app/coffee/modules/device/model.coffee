
class DeviceModel extends Backbone.Model

  connect: ->
    Backbone.Radio.channel('bluetooth').request('connect', @)

  disconnect: ->
    Backbone.Radio.channel('bluetooth').request('disconnect', @)

  isConnected: ->
    Backbone.Radio.channel('bluetooth').request('is:connected', @)

  readRSSI: ->
    Backbone.Radio.channel('bluetooth').request('read:rssi', @)

# # # # #

module.exports = DeviceModel
