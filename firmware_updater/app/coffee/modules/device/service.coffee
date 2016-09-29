DeviceCollection = require './collection'

# # # # #

class DeviceService extends Marionette.Service

  # Temporary work-around while Chromium source downloads
  logJson: (obj) ->
    $('body').append(JSON.stringify(obj, null, 2))
    $('body').append('<br><br>')

  radioRequests:
    'device model':       'model'
    'device collection':  'collection'

  initialize: ->
    @collectionCache = new DeviceCollection()
    chrome.usb.onDeviceAdded.addListener( (device) => @onDeviceAdded(device) )
    chrome.usb.onDeviceRemoved.addListener( (device) => @onDeviceRemoved(device) )

  onDeviceAdded: (device) ->
    # @logJson({ added: true, d: device })
    @collectionCache.add(device, { parse: true })

  onDeviceRemoved: (device) ->
    # @logJson({ removed: true, d: device })
    @collectionCache.remove(device.device)

  model: (id) ->
    return new Promise (resolve,reject) =>
      model = @collectionCache.get(id)
      return resolve(model)

  collection: ->
    return new Promise (resolve,reject) =>
      Backbone.Radio.channel('usb').request('devices') # TODO - USB service should merge into this
      .then (devices) =>
        @collectionCache.set(devices, { parse: true })
        return resolve(@collectionCache)

# # # # #

module.exports = new DeviceService()
