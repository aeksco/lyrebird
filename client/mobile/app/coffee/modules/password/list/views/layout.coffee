
# PasswordEmpty class definition
# Defines a Marionette.LayoutView that's shown when no passwords are found
class PasswordEmpty extends Marionette.LayoutView
  template: require './templates/password_empty'
  tagName: 'li'
  className: 'list-group-item list-group-item-warning'

# # # # #

# PasswordChild class definition
# Defines a Marionette.LayoutView to display a single password
class PasswordChild extends Marionette.LayoutView
  template: require './templates/password_child'
  tagName: 'a'
  className: 'list-group-item'

  attributes: ->
    return { href: '#passwords/' + @model.id }

# # # # #

# PasswordList class definition
# Defines a Marionette.LayoutView to show a PasswordChild
# view instance for each Password found, or display a PasswordEmpty
# vinew instance if none are found.
class PasswordList extends Marionette.CollectionView
  tagName: 'ul'
  className: 'list-group'
  childView: PasswordChild
  emptyView: PasswordEmpty

# # # # #

# PasswordListLayout class definition
# Defines a Marionette.LayoutView in which the PasswordList is shown.
class PasswordListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'

  onRender: ->
    @listRegion.show new PasswordList({ collection: @collection })

# # # # #

module.exports = PasswordListLayout
