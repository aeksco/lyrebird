
fs = require 'fs'

# # # # #

console.log 'Background Document Ready'

# Read file?
fs.readFile './LyrebirdFirmware.hex', (err, data) =>
  if err
    throw err
  console.log(data)

  # Firmware readable from client
  window.global.firmware = data

# http = require 'http'
# http.createServer( (request, response) =>
#   fs.readFile './LyrebirdFirmware.hex', (err, data) =>
#     response.writeHead(200)
#     response.write(data)
#     response.end()
# ).listen(8080)
