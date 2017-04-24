
mock_device =
  id:     "04:A3:16:0A:66:4A"
  name:   "Lyrebird"
  rssi:   -75

# # # # #

# BluetoothService class definition
# The BluetoothService provides an interface to manage
# Bluetooth interactions in the applicaiton.
# Most actions are implemented with Promises to more effectively
# manage asynchronous actions in the application.
class BluetoothDevService extends Marionette.Service

  radioRequests:
    'bluetooth is:enabled':   'isEnabled'
    'bluetooth force:enable': 'forceEnable'
    'bluetooth connect':      'connect'
    'bluetooth disconnect':   'disconnect'
    'bluetooth is:connected': 'isConnected'
    'bluetooth read:rssi':    'readRSSI'
    'bluetooth write':        'write'

  radioEvents:
    'bluetooth start:scan': 'startScan'
    'bluetooth stop:scan':  'stopScan'

  startScan: (success, error) ->
    console.log 'Bluetooth - start scan'
    # ble.startScan([], success, error)
    setTimeout(success(mock_device))

  stopScan: (success, error) ->
    console.log 'Bluetooth - stop scan'
    # ble.stopScan(success, error)

  # Checks if Bluetooth is enabled on the mobile device
  isEnabled: ->
    return new Promise (resolve, reject) =>
      success = -> return resolve(true)
      failure = -> return reject(new Error('Bluetooth is not enabled'))
      success()
      # ble.isEnabled(success, failure)

  # Forces Bluetooth-ON on the mobile device
  forceEnable: ->
    return new Promise (resolve, reject) =>
      success = -> return resolve(true)
      failure = -> return reject(new Error('Bluetooth cannot be auto-enabled'))
      success()
      # ble.enable(success, failure)

  # Connect to Bluetooth device
  connect: (device) ->
    return new Promise (resolve, reject) =>
      success = (dev) ->
        dev.connected = true
        device.set(dev)
        return resolve(dev)
      failure = (err) -> return reject(new Error(err))

      # TODO - dev
      setTimeout( =>
        success(mock_device)
      , 750 )
      # ble.connect(device.id, success, failure)

  # Disconnect from Bluetooth device
  disconnect: (device) ->
    return new Promise (resolve, reject) =>
      success = (dev) ->
        device.set('connected', false)
        return resolve(dev)
      failure = -> return reject(new Error('Cannot disconnect from bluetooth device'))

      # TODO - dev
      success(mock_device)
      # ble.disconnect(device.id, success, failure)

  # Checks connection to Bluetooth device
  isConnected: (device) ->
    return new Promise (resolve, reject) =>
      success = -> return resolve(true)
      failure = -> return reject(new Error('Device is not connected'))
      success()
      # ble.isConnected(device.id, success, failure)

  # Reads the RSSI from a connected device
  # Sets the RSSI attribute on the Device model passed in
  readRSSI: (device) ->
    return new Promise (resolve, reject) =>
      success = (rssi) ->
        device.set('rssi', rssi)
        return resolve(device)
      failure = (err) -> return reject(new Error(err))
      success(100)
      # ble.readRSSI(device.id, success, failure)

  # Writes a packet to a connected device
  # NOTE: does not wait for response from device
  write: (device, data) ->
    packet = new Uint8Array(data).buffer
    console.log 'write to device', packet
    # ble.writeWithoutResponse(device.id, "FFE0", "FFE1", packet)

# # # # #

module.exports = new BluetoothDevService()
