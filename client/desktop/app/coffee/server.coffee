
fs = require 'fs'

# # # # #

console.log 'Background Document Ready'
# console.log fs

# Read file?
# fs.readFile './LyrebirdFirmware.hex', (err, data) =>
#   if err
#     throw err
#   console.log(data)

http = require 'http'

http.createServer( (request, response) =>

  fs.readFile './LyrebirdFirmware.hex', (err, data) =>
    response.writeHead(200)
    response.write(data)
    response.end()

).listen(8080)
