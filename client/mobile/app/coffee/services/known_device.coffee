
# KnownDeviceModel class definition
# Defines a standard Backbone.Model class used by
# the KnownDeviceCollection store KnownDevices offline
class KnownDeviceModel extends Backbone.Model
  urlRoot: '/known_devices/'

# # # # #

# KnownDeviceCollection class definition
# Defines a basic Backbone.Collection to store devices
# to which the app has connected before. These are stored offline
# in window.localStorage with Backbone.DualStorage.
class KnownDeviceCollection extends Backbone.Collection
  url: '/known_devices/'
  model: KnownDeviceModel
  local: true  # Backbone.DualStorage configuration

# # # # #

# KnownDeviceStorage class definition
# The KnownDeviceStorage provides an interface to manage
# Lyrebird devices to which the app has connected before.
# This enables the auto-connect view to connect to devices
# that
# Most actions are implemented with Promises to more effectively
# manage asynchronous actions in the application.
class KnownDeviceStorage extends Marionette.Service

  radioRequests:
    'known:device collection': 'collection'

  radioEvents:
    'known:device add':     'addDevice'
    'known:device remove':  'removeDevice'

  initialize: ->
    @cached = new KnownDeviceCollection()

  collection: -> # Fetches from localStorage
    return new Promise (resolve,reject) =>
      @cached.on 'sync', => resolve(@cached) # Success callback
      @cached.fetch()

  addDevice: (device) ->
    @cached.create({ id: device.id }, {remote: false})
    device.set('known', true)

  removeDevice: (device) ->
    device.set('known', false)
    @cached.remove(device.id)

# # # # #

module.exports = new KnownDeviceStorage()
