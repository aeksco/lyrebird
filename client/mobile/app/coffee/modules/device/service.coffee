DeviceCollection = require './collection'

# # # # #

class DeviceService extends Marionette.Service

  radioRequests:
    'device model': 'model'
    'device collection': 'collection'

  radioEvents:
    'device refresh': 'refresh'

  initialize: ->

    # Gets currently known devices
    Backbone.Radio.channel('known:device').request('collection')
    .then (knownDevices) => @knownDevices = knownDevices

    @collectionCache = new DeviceCollection()

  refresh: ->

    # Throttles multiple calls to refresh
    return if @scanning

    # Resets collection
    # TODO - this isn't a reliable solution
    # Instead we must rescan for devices and reset the collection
    # with the union of its models and the scan result
    @collectionCache.reset([])

    # Success callback
    onDeviceFound = (device) =>
      return unless device.name == 'Lyrebird'
      device.known = !!@knownDevices.get(device.id)
      @collectionCache.add device

    # Error callback
    onScanError = () ->
      console.log 'ERROR FETCHING DEVICES'
      return

    # Starts scan
    ble.startScan([], onDeviceFound, onScanError)

    onScanComplete = =>
      console.log 'Scan complete'
      @scanning = false

    onStopFail = => console.log 'StopScan failure'

    # Stops scan after 5 seconds
    @scanning = true
    setTimeout(ble.stopScan, 5000, onScanComplete, onStopFail)


  model: (id) ->
    return new Promise (resolve,reject) =>
      resolve(@collectionCache.get(id))

  # TODO - a lot of this should be abstracted into the bluetooth service
  collection: ->

    return new Promise (resolve,reject) =>

      # Invokes refresh with respect to this collection
      @refresh()

      # Returns collection, async
      return resolve(@collectionCache)

# # # # #

module.exports = new DeviceService()
