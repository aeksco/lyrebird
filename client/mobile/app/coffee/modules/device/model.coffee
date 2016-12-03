charMap = require './charMap' # TODO - rethink this approach

# # # # #

# Observes connection and sends leave-behind alerts
# TODO - should this be part of the Bluetooth service?
class ConnectionObserver extends Marionette.Object

  initialize: (options) =>
    @device = options.device
    setTimeout(@checkPoll, 2000)

  checkPoll: =>
    return @startPolling() if @device.get('connected')
    @stopPolling()

  startPolling: =>
    return if @interval
    @interval = setInterval( @device.readRSSI, 500 )
    setInterval(@sendAlert, 500)

  # Send Alerts
  sendAlert: =>
    # console.log @device.get('rssi')

    # TODO - RSSI threshold should be a user setting
    if @device.get('rssi') < -80

      # Leave - behind alerts
      # TODO - different sound?
      # TODO - haptic feedback intensity?
      plugins.deviceFeedback.haptic()
      plugins.deviceFeedback.acoustic()

  stopPolling: =>
    return unless @interval
    clearInterval(@interval)
    delete @interval

# # # # #

class DeviceModel extends Backbone.Model

  connect: ->
    window.device = @ # TODO - remove
    Backbone.Radio.channel('bluetooth').request('connect', @)
    @connectionObserver = new ConnectionObserver({ device: @ }) # TODO - move this elsewhere?

  disconnect: ->
    Backbone.Radio.channel('bluetooth').request('disconnect', @)
    @connectionObserver.stopPolling() # TODO - RSSI polling

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

  # # # # #
  # TODO - abstract into Device.Keyboard
  writeKeyup: =>
    @write([2,0,0,0,0,0,0])

  # TODO - remove can uppercase
  # charMap should include uppercase characters
  canUppercase: (char) ->
    return false  if char == charMap[' ']
    return true   if char == char.toUpperCase()
    return false

  # TODO - gotta get uppercase working!
  # TODO - remove this after debugging
  # Format? [modifier, reserved, Key1, Key2, Key3, Key4, Key5, Key6]
  # writeKeydown: (report) ->
  #   @write(report)

  writeKeydown: (char) =>

    # Uppercase testing
    # if @canUppercase(char)
    #   shift = 225 # LShift
    #   # shift = 57 # Caps Lock
    # else
    #   shift = 0

    # char = charMap[char.toLowerCase()]

    char = charMap[char]
    @write([2,0,0,char,0,0,0,0])

  writeChar: (char) =>
    @writeKeydown(char)
    @writeKeyup()

  sendText: (text = 'lyrebird') =>
    @writeChar(char) for char in text
    return true
  #
  # # # # #

  # # # # #
  # TODO - abstract into Device.Mouse
  clickMouseLeft: =>
    @write([1,0,0,1])
    @write([1,0,0,0])

  clickMouseRight: =>
    @write([1,0,0,2])
    @write([1,0,0,0])

  writeMousePos: (pos) =>
    @write([1,pos.x,pos.y,0])
  #
  # # # # #

# # # # #

module.exports = DeviceModel
