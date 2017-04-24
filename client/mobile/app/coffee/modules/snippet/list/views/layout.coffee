
# SnippetEmpty class definition
# Defines a Marionette.LayoutView that's shown when no snippets are found
class SnippetEmpty extends Marionette.LayoutView
  template: require './templates/snippet_empty'
  tagName: 'ons-list-item'

# # # # #

# SnippetChild class definition
# Defines a Marionette.LayoutView to display a single snippet
class SnippetChild extends Marionette.LayoutView
  template: require './templates/snippet_child'
  tagName: 'ons-list-item'

  events:
    'click': 'onClick'

  onClick: ->
    window.fn.load('snippet:show', @model.id)

# # # # #

# SnippetList class definition
# Defines a Marionette.LayoutView to show a SnippetChild
# view instance for each Snippet found, or display a SnippetEmpty
# vinew instance if none are found.
class SnippetList extends Marionette.CollectionView
  tagName: 'ons-list'
  childView: SnippetChild
  emptyView: SnippetEmpty

# # # # #

# SnippetListLayout class definition
# Defines a Marionette.LayoutView in which the SnippetList is shown.
class SnippetListLayout extends Marionette.LayoutView
  template: require './templates/layout'

  tagName: 'ons-page'

  regions:
    listRegion: '[data-region=list]'

  onRender: ->
    @listRegion.show new SnippetList({ collection: @collection })

# # # # #

module.exports = SnippetListLayout
