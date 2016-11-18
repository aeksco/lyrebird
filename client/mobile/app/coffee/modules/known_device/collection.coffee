
class KnownDeviceCollection extends Backbone.Collection
  url: '/known_devices/'
  model: require './model'
  local: true  # Backbone.DualStorage configuration

# # # # #

module.exports = KnownDeviceCollection
