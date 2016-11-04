
class BluetoothService extends Marionette.Service

  radioRequests:
    'bluetooth is:enabled':   'isEnabled'
    'bluetooth force:enable': 'forceEnable'
    'bluetooth connect':      'connect'
    'bluetooth disconnect':   'disconnect'
    'bluetooth is:connected': 'isConnected'
    'bluetooth read:rssi':    'readRSSI'

  isEnabled: ->
    return new Promise (resolve, reject) =>
      success = -> return resolve(true)
      failure = -> return reject(new Error('Bluetooth is not enabled'))
      ble.isEnabled(success, failure)

  forceEnable: ->
    return new Promise (resolve, reject) =>
      success = -> return resolve(true)
      failure = -> return reject(new Error('Bluetooth cannot be auto-enabled'))
      ble.enable(success, failure)

  # Connect to device
  connect: (device_id) ->
    return new Promise (resolve, reject) =>
      success = (dev) -> return resolve(dev)
      failure = (err) -> return reject(new Error(err))
      ble.connect(device_id, success, failure)

  disconnect: (device_id) ->
    console.log 'attempting to disconnect...'
    return new Promise (resolve, reject) =>
      success = -> return resolve(true)
      failure = -> return reject(new Error('Cannot disconnect from bluetooth device'))
      ble.disconnect(success, failure)

  isConnected: (device_id) ->
    console.log 'attempting to check connection...'
    return new Promise (resolve, reject) =>
      success = -> return resolve(true)
      failure = -> return reject(new Error('Device is not connected'))
      ble.isConnected(device_id, success, failure)

  readRSSI: (device_id) ->
    return new Promise (resolve, reject) =>
      success = (dev) -> return resolve(dev)
      failure = (err) -> return reject(new Error(err))
      ble.readRSSI(device_id, success, failure)

# # # # #

module.exports = new BluetoothService()
