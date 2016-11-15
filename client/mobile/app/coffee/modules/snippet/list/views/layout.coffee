
class SnippetEmpty extends Marionette.LayoutView
  template: require './templates/snippet_empty'
  tagName: 'li'
  className: 'list-group-item list-group-item-warning'

# # # # #

class SnippetChild extends Marionette.LayoutView
  template: require './templates/snippet_child'
  tagName: 'a'
  className: 'list-group-item'

  attributes: ->
    return { href: '#snippets/' + @model.id }

# # # # #

class SnippetList extends Marionette.CollectionView
  tagName: 'ul'
  className: 'list-group'
  childView: SnippetChild
  emptyView: SnippetEmpty

# # # # #

class SnippetListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'

  onRender: ->
    @listRegion.show new SnippetList({ collection: @collection })


# # # # #

module.exports = SnippetListLayout
