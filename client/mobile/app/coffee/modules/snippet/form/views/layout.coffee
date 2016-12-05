
# SnippetForm class definition
# Defines a Marionette.LayoutView class for collecting
# parameters used to create or update a SnippetModel
class SnippetForm extends Marionette.LayoutView
  className: 'row'
  template: require './templates/form'

  behaviors:
    SubmitButton: {}

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )

  onSubmit: (e) ->
    attrs = Backbone.Syphon.serialize(@)

    Backbone.Radio.channel('snippet').request('collection')
    .then (collection) =>
      collection.create(attrs, {remote: false})

      # Invokes onSync callback
      @onSync()

  onError: ->
    console.log 'ON ERROR'

  onSync: ->
    window.location = '#snippets'

# # # # #

module.exports = SnippetForm
