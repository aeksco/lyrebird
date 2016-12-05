charMap = require './charMap' # TODO - rethink this approach
ConnectionObserver = require './connectionObserver'

# # # # #

# DeviceModel class definition
# Defines a class to interface with a Lyrebird device connected via bluetooth
class DeviceModel extends Backbone.Model

  # Connects to device
  connect: ->
    window.device = @ # TODO - remove
    Backbone.Radio.channel('bluetooth').request('connect', @)
    @connectionObserver = new ConnectionObserver({ device: @ }) # TODO - move this elsewhere?

  # Disconnects from device
  disconnect: ->
    Backbone.Radio.channel('bluetooth').request('disconnect', @)
    @connectionObserver.stopPolling() # TODO - RSSI polling

  # Checks device connection
  isConnected: ->
    Backbone.Radio.channel('bluetooth').request('is:connected', @)

  # Reads device RSSI
  readRSSI: =>
    Backbone.Radio.channel('bluetooth').request('read:rssi', @)

  # Remember device (interfaces with KnownDeviceStorage)
  remember: ->
    Backbone.Radio.channel('known:device').trigger('add', @)

  # Forgets device (interfaces with KnownDeviceStorage)
  forget: ->
    Backbone.Radio.channel('known:device').trigger('remove', @)

  # Writes
  write: (data) =>
    Backbone.Radio.channel('bluetooth').request('write', @, data)

  # Writes two packets with a delay
  # This is a debugging method and will be removed
  # in a future build
  writeDual: (rp1, rp2, delay=false) =>

    if delay
      @write(rp1)
      setTimeout( =>
        @write(rp2)
      , delay)

    else
      @write(rp1)
      @write(rp2)

  # Keyboard commands

  # Writes keyup (clears keyboard)
  writeKeyup: =>
    @write([3,0,0,0,0,0,0,0])

  # Keydown for a character
  writeKeydown: (char) =>

    # Packet construction
    control = [3]
    charArr = charMap[char]
    padding = [0,0,0,0,0]
    packet  = control.concat(charArr).concat(padding)

    # Sends packet
    @write(packet)

  # Keyup / Keydown on a single character
  writeChar: (char) =>
    @writeKeydown(char)
    @writeKeyup()

  # Sends a string as a series of writeChar commands
  sendText: (text = 'lyrebird') =>
    @writeChar(char) for char in text
    return true

  # Mouse commands
  clickMouseLeft: =>
    @write([2,1])
    @write([2,0])

  clickMouseRight: =>
    @write([2,2])
    @write([2,0])

  clickMouseMiddle: =>
    @write([2,4])
    @write([2,0])

  writeMousePos: (pos) =>
    @write([1,pos.x,pos.y])

  #
  # # # # #

# # # # #

module.exports = DeviceModel
