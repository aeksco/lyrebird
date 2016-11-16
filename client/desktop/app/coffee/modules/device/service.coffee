DeviceCollection = require './collection'

# # # # #

class DeviceService extends Marionette.Service

  radioRequests:
    'device model':       'model'
    'device collection':  'collection'

  initialize: ->
    @collectionCache = new DeviceCollection()
    chrome.usb.onDeviceAdded.addListener( (device) => @onDeviceAdded(device) )
    chrome.usb.onDeviceRemoved.addListener( (device) => @onDeviceRemoved(device) )

  onDeviceAdded: (device) ->
    @collectionCache.add(device, { parse: true })

  onDeviceRemoved: (device) ->
    @collectionCache.remove(device.device)

  model: (id) ->
    return new Promise (resolve,reject) =>
      model = @collectionCache.get(id)
      return resolve(model)

  collection: ->
    return new Promise (resolve,reject) =>

      # Return cached
      return resolve(@collectionCache) if @parsed

      # Fetch devices
      Backbone.Radio.channel('usb').request('devices') # TODO - USB service should merge into this
      .then (devices) =>
        @parsed = true
        @collectionCache.reset(devices, { parse: true })
        return resolve(@collectionCache)

# # # # #

module.exports = new DeviceService()
