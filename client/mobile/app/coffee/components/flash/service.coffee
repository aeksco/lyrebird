FlashCollection = require './collection'

# # # # #

class FlashService extends Backbone.Marionette.Service

  radioRequests:
    'flash collection': 'getCollection'

  alerts: null

  getCollection: ->
    return new Promise (resolve,reject) =>
      @alerts ||= new FlashCollection()
      resolve(@alerts)
      return

# # # # #

module.exports = new FlashService()
