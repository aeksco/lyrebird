
class ModelEventsBehavior extends Marionette.Behavior

  modelEvents:
    'request':  'onModelRequest'
    'sync':     'onModelSync'
    'error':    'onModelError'

  onModelRequest: (model, status, options) ->
    @view.onRequest?(model, status, options)

  onModelSync: (model, response, options) ->
    @view.onSync?(model, response, options)

  onModelError: (model, response, options) ->
    @view.onError?(model, response, options)

# # # # #

module.exports = ModelEventsBehavior
