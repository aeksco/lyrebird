
# SnippetEmpty class definition
# Defines a Marionette.LayoutView that's shown when no snippets are found
class SnippetEmpty extends Marionette.LayoutView
  template: require './templates/snippet_empty'
  tagName: 'li'
  className: 'list-group-item list-group-item-warning'

# # # # #

# SnippetChild class definition
# Defines a Marionette.LayoutView to display a single snippet
class SnippetChild extends Marionette.LayoutView
  template: require './templates/snippet_child'
  tagName: 'a'
  className: 'list-group-item'

  attributes: ->
    return { href: '#snippets/' + @model.id }

# # # # #

# SnippetList class definition
# Defines a Marionette.LayoutView to show a SnippetChild
# view instance for each Snippet found, or display a SnippetEmpty
# vinew instance if none are found.
class SnippetList extends Marionette.CollectionView
  tagName: 'ul'
  className: 'list-group'
  childView: SnippetChild
  emptyView: SnippetEmpty

# # # # #

# SnippetListLayout class definition
# Defines a Marionette.LayoutView in which the SnippetList is shown.
class SnippetListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'

  onRender: ->
    @listRegion.show new SnippetList({ collection: @collection })


# # # # #

module.exports = SnippetListLayout
