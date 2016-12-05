SnippetForm = require '../../form/views/layout'

# # # # #

# NewSnippetLayout class definition
# Defines a Marionette.LayoutView that acts as a wrapper
# to the SnippetForm defined in an outside file
class NewSnippetLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    formRegion: '[data-region=form]'

  onRender: ->
    @formRegion.show new SnippetForm({ model: @model, type: type })

# # # # #

module.exports = NewSnippetLayout
