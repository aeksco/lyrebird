
class SnippetShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  # TODO - destroy model

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    return data

# # # # #

module.exports = SnippetShowLayout
