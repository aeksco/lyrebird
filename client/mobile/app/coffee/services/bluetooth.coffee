
class BluetoothService extends Marionette.Service

  radioRequests:
    'bluetooth is:enabled':   'isEnabled'
    'bluetooth force:enable': 'forceEnable'
    'bluetooth connect':      'connect'
    'bluetooth disconnect':   'disconnect'
    'bluetooth is:connected': 'isConnected'

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

  connect: (device_id) ->
    console.log 'attempting to connect...'
    return new Promise (resolve, reject) =>
      success = (dev) ->
        console.log 'success'
        console.log dev
        return resolve(true)

      failure = (err) ->
        console.log 'ERROR'
        console.log err
        return reject(new Error('Cannot connect to bluetooth device'))
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

# # # # #

module.exports = new BluetoothService()
