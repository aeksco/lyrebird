
class UsbService extends Marionette.Service

  radioRequests:
    'usb devices':  'getDevices'

  getDevices: ->
    return new Promise (resolve, reject) =>
      success = (devices) -> return resolve(devices)
      enumerateDevicesOptions = {}
      chrome.usb.getDevices(enumerateDevicesOptions, success)

# # # # #

module.exports = new UsbService()
