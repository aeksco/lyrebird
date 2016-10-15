
# # # # #

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

class DeviceShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  events:
    'click [data-click=connect]': 'connectToDevice'

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    data

  connectToDevice: ->
    console.log 'CONNECT TO DEVICE'
    # console.log @model

    device = @model.attributes
    console.log device

    # This is temporary - device backbone model should store its attributes separately from its standard attributes
    delete device.id

    # Promisified open device
    chrome.usb.promise.openDevice(device)
    .then (connectionHandle) =>
      console.log 'opened device with promise - yay!'
      console.log connectionHandle

      # Claim interface
      interfaceNumber = 0
      chrome.usb.promise.claimInterface(connectionHandle, interfaceNumber)
      .then () ->
        console.log 'Interface claimed!'

        # Interrupt Transfer Options
        # interruptTransferOpts =
        #   direction:  'out'
        #   endpoint:   1
        #   data:       {} # TODO - what is obj?

        # # Write firmware..?
        # chrome.usb.interruptTransfer connectionHandle, interruptTransferOpts, (result) ->
        #   console.log 'InterruptTransfer complete'
        #   console.log result

    #     # # Control Transfer Options
    #     # controlTransferOpts =
    #     #   direction:    'in'
    #     #   recipient:    'device'
    #     #   requestType:  'standard'

    #     # # GET_STATUS Request
    #     # getStatus =
    #     #   request:      0x00
    #     #   value:        0
    #     #   index:        0
    #     #   length:       64

    #     # # Compiles transfer options
    #     # transferOpts = _.extend controlTransferOpts, getStatus

    #     # console.log transferOpts

    #     # # Control Transfer
    #     # chrome.usb.controlTransfer connectionHandle, transferOpts, (result) =>
    #     #   console.log 'CONTROL TRANSFER COMPLETE'
    #     #   console.log result


# # # # #

module.exports = DeviceShowLayout
