# TODO - abstract into separate library

# Chrome usbPromise library
chrome.usb.promise = {}

chrome.usb.promise.openDevice = (device) ->
  return new Promise (resolve, reject) ->
    chrome.usb.openDevice(device, (connectionHandle) -> resolve(connectionHandle))

chrome.usb.promise.claimInterface = (connectionHandle, interfaceNumber) ->
  return new Promise (resolve, reject) ->
    chrome.usb.claimInterface(connectionHandle, interfaceNumber, -> resolve() )

# # # # #

class DeviceModel extends Backbone.Model

  defaults:
    usb:    {}
    handle: {}

  parse: (resp) ->
    return attrs = {
      id:   resp.device
      usb:  resp
    }

  disconnect: ->
    console.log 'DISCONNECT DEVICE'

  open: ->
    return new Promise (resolve, reject) =>
      chrome.usb.promise.openDevice(@get('usb'))
      .then (connectionHandle) =>
        @set('handle', connectionHandle)
        return resolve()

  claim: ->
    interfaceNumber = 0
    return chrome.usb.promise.claimInterface(@get('handle'), interfaceNumber)

  transfer: ->
    # Interrupt Transfer Options
    interruptTransferOpts =
      direction:  'out'
      endpoint:   1
      data:       {} # TODO - what is obj?

    # Write firmware..?
    return new Promise (resolve, reject) =>
      chrome.usb.interruptTransfer @get('handle'), interruptTransferOpts, (result) ->
        console.log 'InterruptTransfer complete'
        resolve(result)

  loadFirmware: ->
    console.log 'LOAD FIRMWARE'
    # console.log window.global.firmware

    firmware = window.global.firmware

    bufferPromise = Promise.reduce packets, (res,packet) =>
            @_sendCommand(packet,false).then => Promise.delay(1000) if i is 1
        , null

    for line in firmware
      console.log line

  # # # # #

  controlTransfer: ->
    # # Control Transfer Options
    # controlTransferOpts =
    #   direction:    'in'
    #   recipient:    'device'
    #   requestType:  'standard'

    # # GET_STATUS Request
    # getStatus =
    #   request:      0x00
    #   value:        0
    #   index:        0
    #   length:       64

    # # Compiles transfer options
    # transferOpts = _.extend controlTransferOpts, getStatus

    # console.log transferOpts

    # # Control Transfer
    # chrome.usb.controlTransfer connectionHandle, transferOpts, (result) =>
    #   console.log 'CONTROL TRANSFER COMPLETE'
    #   console.log result

# # # # #

module.exports = DeviceModel
