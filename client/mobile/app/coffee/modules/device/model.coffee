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

  write: (data) =>
    Backbone.Radio.channel('bluetooth').request('write', @, data)

  writeKeyup: =>
    @write([2,0,0,0,0,0,0])

  canUppercase: (char) ->
    return false  if char == charMap[' ']
    return true   if char == char.toUpperCase()
    return false

  writeKeydown: (char) =>

    # Uppercase testing
    if @canUppercase(char)
      shift = 225 # LShift
      # shift = 57 # Caps Lock
    else
      shift = 0

    console.log shift
    console.log char

    @write([2,shift,charMap[char.toLowerCase()],0,0,0,0])

  clickMouseLeft: =>
    @write([1,0,0,1])
    @write([1,0,0,0])

  clickMouseRight: =>
    @write([1,0,0,2])
    @write([1,0,0,0])

  writeChar: (char) =>
    @writeKeydown(char)
    @writeKeyup()

  writeMousePos: (pos) =>
    @write([1,pos.x,pos.y,0])

  sendText: (text = 'lyrebird') =>
    @writeChar(char) for char in text
    return true

# # # # #

module.exports = DeviceModel
