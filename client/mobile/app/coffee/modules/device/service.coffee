DeviceCollection = require './collection'

# # # # #

class DeviceService extends Marionette.Service

  radioRequests:
    'device model': 'model'
    'device collection': 'collection'

  initialize: ->
    @collectionCache = new DeviceCollection()

  model: (id) ->
    return new Promise (resolve,reject) =>
      resolve(@collectionCache.get(id))

  # TODO - a lot of this should be abstracted into the bluetooth service
  collection: ->

    return new Promise (resolve,reject) =>

      # Resets collection
      # @collectionCache.reset([])

      foundDevices = []

      # Success callback
      onDeviceFound = (device) =>
        # console.log 'FOUND DEVICE'
        # console.log JSON.stringify(device)
        foundDevices.push device
        console.log 'FOUND: ', device
        console.log String.fromCharCode.apply(null, new Uint8Array(device.advertising))
        console.log '# # # # # # '
        @collectionCache.add device

      # Error callback
      onScanError = () ->
        console.log 'ERROR FETCHING DEVICES'
        return

      # Starts scan
      ble.startScan([], onDeviceFound, onScanError)

      onScanComplete = =>
        console.log 'Scan complete'
        @collectionCache.reset(foundDevices)

      onStopFail = => console.log 'StopScan failure'

      # Stops scan after 5 seconds
      setTimeout(ble.stopScan, 5000, onScanComplete, onStopFail)

      # Returns collection, async
      return resolve(@collectionCache)

# # # # #

module.exports = new DeviceService()
