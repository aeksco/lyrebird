# TODO - rethink this approach
charMap = {
  a:      4
  b:      5
  c:      6
  d:      7
  e:      8
  f:      9
  g:      10
  h:      11
  i:      12
  j:      13
  k:      14
  l:      15
  m:      16
  n:      17
  o:      18
  p:      19
  q:      20
  r:      21
  s:      22
  t:      23
  u:      24
  v:      25
  w:      26
  x:      27
  y:      28
  z:      29
  ' ':    44  # Space
  right:  79  # Right
  left:   80  # Left
  down:   81  # Down
  up:     82  # Up
  enter:  88  # Return
  back:   42  # Backspace
}

class DeviceModel extends Backbone.Model

  connect: ->
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

  writePromise: (dataArray) =>
    return new Promise (resolve,reject) =>
      success = (msg) -> return resolve()
      failure = (err) -> return reject()

      data = new Uint8Array(dataArray).buffer

      # Writes
      ble.write(@id, "FFE0", "FFE1", data, success, failure)

  writeKeyup: => @writePromise([2,0,0,0,0,0,0])

  writeKeydown: (char) => @writePromise([2,charMap[char],0,0,0,0,0])

  writeChar: (char) =>
    promises = [@writeKeydown(char), @writeKeyup()]
    return Promise.all(promises)

  sendText: (text = 'lyrebird') =>
    return Promise.each(text, (char) => return @writeChar(char))

# # # # #

module.exports = DeviceModel
