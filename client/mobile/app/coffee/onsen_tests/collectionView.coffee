
class Child extends Mn.LayoutView
  tagName: 'ons-list-item'
  template: require './child'

  events:
    'click': 'onClick'

  onClick: ->
    console.log 'CLICKED: ', @model.get('name')

# # # # #

class Empty extends Mn.LayoutView
  tagName: 'ons-list-item'
  template: require './empty'

# # # # #

class Collection extends Mn.CompositeView
  template: require './list'

  tagName: 'ons-page'

  attributes:
    id: 'list-view.html'

  childView: Child
  emptyView: Empty
  childViewContainer: '.collection'

  events:
    'click ons-toolbar-button': 'onClick'

# # # # #

module.exports = Collection
