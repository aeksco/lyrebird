
fs = require 'fs'

# # # # #

console.log 'Background Document Ready'

# Read file?
fs.readFile './LyrebirdFirmware.hex', 'utf8', (err, data) =>
# fs.readFile './LyrebirdFirmware.hex', (err, data) =>
  if err
    throw err
  # console.log(data)

  # Firmware readable from client
  window.global.firmware = data

# http = require 'http'
# http.createServer( (request, response) =>
#   fs.readFile './LyrebirdFirmware.hex', (err, data) =>
#     response.writeHead(200)
#     response.write(data)
#     response.end()
# ).listen(8080)


# # # # # # # #

# SerialPortModule = require('serialport')
# SerialPort = SerialPortModule.SerialPort
exec = require('child_process').exec

console.log exec

_dfu = __dirname + '/resources/bin/dfu-programmer'

console.log process.platform

if process.platform == 'win32'

  _dfu = __dirname + 'resources/dfu-programmer/win/dfu-programmer.exe'


console.log _dfu

console.log 'exec???'

exec _dfu + ' at90usb1286 erase', (err, stdout, stderr) ->
  console.log err
  console.log stdout
  console.log stderr

# exec 'export DYLD_LIBRARY_PATH=' + __dirname + '/resources/lib; ' + _dfu + ' at90usb1286 erase', (err, stdout, stderr) ->

#   console.log err
#   console.log stdout
#   console.log stderr

#   if err != null

#     console.log 'exec erase error: ' + err

#     # _e = _.last(String(err).split(':'))
#     console.log err

#     console.log "app.channel.trigger 'flash.error', _e"

#   else

#     console.log "app.channel.trigger 'flash.writing'"

#     exec 'export DYLD_LIBRARY_PATH=' + __dirname + '/resources/lib; ' + _dfu + ' at90usb1286 flash "' + app.imageFile.path + '"', (err, stdout, stderr) ->
#       `var _e`

#       if err != null
#         console.log 'exec flash error: ' + err
#         # _e = _.last(String(err).split(':'))
#         console.log err
#         console.log "app.channel.trigger 'flash.error', _e"
#       else
#         console.log "app.channel.trigger 'flash.completed'"

#       return
#   return
# return
