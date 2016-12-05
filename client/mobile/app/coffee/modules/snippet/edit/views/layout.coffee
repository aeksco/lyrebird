SnippetForm = require '../../form/views/layout'

# # # # #

# EditSnippetLayout class definition
# Defines a Marionette.LayoutView that acts as a wrapper
# to the SnippetForm defined in an outside file
class EditSnippetLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    formRegion: '[data-region=form]'

  onRender: ->
    @formRegion.show new SnippetForm({ model: @model, type: @model.get('type') })

# # # # #

module.exports = EditSnippetLayout
