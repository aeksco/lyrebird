PasswordModel = require './model'
PasswordCollection = require './collection'

# # # # #

# TODO - abstract this service into a OFFLINE super-class
# TODO - this should be OFFLINE
class PasswordService extends Marionette.Service

  radioRequests:
    'password model':      'model'
    'password collection': 'collection'

  model: (id) ->
    return new Promise (resolve,reject) =>

      # Return new unless ID specified
      return resolve(new PasswordModel()) unless id

      # Return from Cached
      if @cached
        return resolve(@cached.get(id))
      else
        @collection().then () =>
          return resolve(@cached.get(id))

  collection: ->
    return new Promise (resolve,reject) =>

      # Return cached
      # return resolve(@cached) if @cached

      # Instantiates @cached collection
      @cached = new PasswordCollection()
      @cached.on 'sync', => resolve(@cached) # Success callback
      @cached.fetch()

      return

# # # # #

module.exports = new PasswordService()
