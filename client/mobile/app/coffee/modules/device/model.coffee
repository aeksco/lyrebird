charMap = {
  a:4
  b:5
  c:6
  d:7
  e:8
  f:9
  g:10
  h:11
  i:12
  j:13
  k:14
  l:15
  m:16
  n:17
  o:18
  p:19
  q:20
  r:21
  s:22
  t:23
  u:24
  v:25
  w:26
  x:27
  y:28
  z:29
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

  writeTest: (service_uuid, characteristic_uuid, data) =>

    success = (msg) ->
      console.log 'SUCCESS'
      console.log typeof msg
      console.log msg
      console.log String.fromCharCode.apply(null, new Uint8Array(msg))

    failure = (err) ->
      console.log 'FAILURE'
      console.log typeof err
      console.log err

    console.log 'Writing...'
    console.log data

    # Writes
    ble.write(@id, service_uuid, characteristic_uuid, data, success, failure)

  writeKeyup: (char) =>
    return new Promise (resolve,reject) =>
      success = (msg) -> return resolve()
      failure = (err) -> return reject()

      data = new Uint8Array([2,0,0,0,0,0,0]).buffer

      # Writes
      ble.write(@id, "FFE0", "FFE1", data, success, failure)

  writeKeydown: (char) =>
    return new Promise (resolve,reject) =>
      success = (msg) -> return resolve()
      failure = (err) -> return reject()

      charNum = charMap[char]
      data = new Uint8Array([2,charNum,0,0,0,0,0]).buffer

      # Writes
      ble.write(@id, "FFE0", "FFE1", data, success, failure)

  writePromise: (char) =>
    promises = [@writeKeydown(char), @writeKeyup(char)]
    return Promise.all(promises)

  sendText: (text = 'lyrebird') =>
    return Promise.each(text, (char) => return @writePromise(char))

  readTest: (service_uuid, characteristic_uuid) =>

    success = (msg) ->
      console.log 'READ SUCCESS'
      console.log typeof msg
      console.log msg
      console.log new Uint8Array(msg).length
      console.log String.fromCharCode.apply(null, new Uint8Array(msg))

    failure = (err) ->
      console.log 'READ FAILURE'
      console.log typeof err
      console.log err

    console.log 'Reading...'

    # Writes
    ble.read(@id, service_uuid, characteristic_uuid, success, failure)

# # # # #

module.exports = DeviceModel
