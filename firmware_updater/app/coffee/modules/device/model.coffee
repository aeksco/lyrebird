
class DeviceModel extends Backbone.Model

  # TODO
  # idAttribute: 'device'
  parse: (resp) ->
    resp.id = resp.device
    return resp

# # # # #

module.exports = DeviceModel
