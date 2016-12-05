
# DeviceCollection class definition
# Defines a Backbone.Collection to manage
# Bluetooth devices in the app
class DeviceCollection extends Backbone.Collection
  model: require './model'

# # # # #

module.exports = DeviceCollection
