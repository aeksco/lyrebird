
class ContactListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  collectionEvents:
    'add':    'render'
    'reset':  'render'
    'remove': 'render'

# # # # #

module.exports = ContactListLayout
