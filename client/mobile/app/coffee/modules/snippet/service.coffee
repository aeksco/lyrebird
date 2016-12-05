SnippetModel = require './model'
SnippetCollection = require './collection'

# # # # #

# SnippetService class definition
# Defines a Marionette.Service class to act as an
# offline storage interface for Snippets
class SnippetService extends Marionette.Service

  radioRequests:
    'snippet model':      'model'
    'snippet collection': 'collection'

  model: (id) ->
    return new Promise (resolve,reject) =>

      # Return new unless ID specified
      return resolve(new SnippetModel()) unless id

      # Return from Cached
      if @cached
        return resolve(@cached.get(id))
      else
        @collection().then () =>
          return resolve(@cached.get(id))

  collection: ->
    return new Promise (resolve,reject) =>

      # Return cached
      return resolve(@cached) if @cached

      # Instantiates @cached collection
      @cached = new SnippetCollection()
      @cached.on 'sync', => resolve(@cached) # Success callback
      @cached.fetch()

      return

# # # # #

module.exports = new SnippetService()
