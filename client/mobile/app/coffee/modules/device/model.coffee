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
    @write([3,0,0,0,0,0,0,0])

  # TODO - gotta get uppercase working!
  # TODO - remove this after debugging
  # Format? [modifier, reserved, Key1, Key2, Key3, Key4, Key5, Key6]
  writeKeydown: (report) ->
    @write(report)

  writeKeydown: (char) =>

    # char = charMap[char.toLowerCase()]
    control = [3]
    charArr = charMap[char]
    padding = [0,0,0,0,0]

    send = control.concat(charArr).concat(padding)
    @write(send)

  writeChar: (char) =>
    @writeKeydown(char)
    @writeKeyup()

  sendText: (text = 'lyrebird') =>
    @writeChar(char) for char in text
    return true
  #
  # # # # #

  writeDual: (rp1, rp2, delay=false) =>

    if delay
      @write(rp1)
      setTimeout( =>
        @write(rp2)
      , delay)

    else
      @write(rp1)
      @write(rp2)

  # # # # #
  # TODO - abstract into Device.Mouse

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
