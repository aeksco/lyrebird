
fs = require 'fs'

# # # # #

console.log 'Background Document Ready'
# console.log fs

# Read file?
fs.readFile './LyrebirdFirmware.hex', (err, data) =>
  if err
    throw err
  console.log(data)
