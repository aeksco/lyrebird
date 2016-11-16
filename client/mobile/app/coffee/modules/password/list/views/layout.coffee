
class PasswordEmpty extends Marionette.LayoutView
  template: require './templates/password_empty'
  tagName: 'li'
  className: 'list-group-item list-group-item-warning'

# # # # #

class PasswordChild extends Marionette.LayoutView
  template: require './templates/password_child'
  tagName: 'a'
  className: 'list-group-item'

  attributes: ->
    return { href: '#passwords/' + @model.id }

# # # # #

class PasswordList extends Marionette.CollectionView
  tagName: 'ul'
  className: 'list-group'
  childView: PasswordChild
  emptyView: PasswordEmpty

# # # # #

class PasswordListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'

  onRender: ->
    @listRegion.show new PasswordList({ collection: @collection })


# # # # #

module.exports = PasswordListLayout
