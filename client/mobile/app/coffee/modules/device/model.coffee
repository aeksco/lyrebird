charMap = require './charMap' # TODO - rethink this approach

# # # # #

class DeviceModel extends Backbone.Model

  connect: ->
    window.device = @ # TODO - remove
    Backbone.Radio.channel('bluetooth').request('connect', @)

  disconnect: ->
    Backbone.Radio.channel('bluetooth').request('disconnect', @)

  isConnected: ->
    Backbone.Radio.channel('bluetooth').request('is:connected', @)

  readRSSI: =>
    Backbone.Radio.channel('bluetooth').request('read:rssi', @)

  remember: ->
    Backbone.Radio.channel('known:device').trigger('add', @)

  forget: ->
    Backbone.Radio.channel('known:device').trigger('remove', @)

  writeFast: (data) => # TODO - use BB.Radio
    packet = new Uint8Array(data).buffer
    ble.writeWithoutResponse(window.device.id, "FFE0", "FFE1", packet)

  writeKeyup: =>
    @writeFast([2,0,0,0,0,0,0])

  writeKeydown: (char) =>

    # Uppercase testing
    @shift ||= 0
    if char == char.toUpperCase()
      # shift = 225 # LShift
      @shift = 57 # Caps Lock
    else
      @shift = 0

    char = char.toLowerCase()
    @writeFast([2,@shift,charMap[char],0,0,0,0])

  clickMouseLeft: =>
    @writeFast([1,0,0,1])
    @writeFast([1,0,0,0])

  clickMouseRight: =>
    @writeFast([1,0,0,2])
    @writeFast([1,0,0,0])

  writeChar: (char) =>
    @writeKeydown(char)
    @writeKeyup()

  writeMousePos: (pos) =>
    @writeFast([1,pos.x,pos.y,0])

  sendText: (text = 'lyrebird') =>
    @writeChar(char) for char in text
    return true

# # # # #

module.exports = DeviceModel
