require './service'
FlashList = require './views/flashList'

# # # # #

class FlashService extends Backbone.Marionette.Service

  initialize: (options = {}) ->
    @container = options.container
    Backbone.Radio.channel('flash').request('collection').then (collection) =>
      @collection = collection
      @collection.on 'update', @showListView, @

  radioEvents:
    'flash add':      'add'
    'flash reset':    'reset'
    'flash error':    'error'
    'flash warning':  'warning'
    'flash success':  'success'

  add: (options = {}) ->
    @collection.add(options)

  reset: ->
    @collection.reset()

  error: (options={}) ->
    @collection.add _.extend( options, { context:  'danger' })

  warning: (options={}) ->
    @collection.add _.extend( options, { context:  'warning' })

  success: (options={}) ->
    @collection.add _.extend( options, { context:  'success' })

  showListView: =>
    unless @rendered
      @container.show new FlashList({ collection: @collection })
      @rendered = true

# # # # #

module.exports = new FlashService({ container: window.Layout.flashRegion })
