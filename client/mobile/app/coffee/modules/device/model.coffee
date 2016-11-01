
class DeviceModel extends Backbone.Model

  connect: ->
    Backbone.Radio.channel('bluetooth').request('connect', @id)

  disconnect: ->
    Backbone.Radio.channel('bluetooth').request('disconnect', @id)

  isConnected: ->
    Backbone.Radio.channel('bluetooth').request('is:connected', @id)

# # # # #

module.exports = DeviceModel
