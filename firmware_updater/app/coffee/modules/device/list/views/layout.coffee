
class DeviceChild extends Marionette.LayoutView
  template: require './templates/child'
  tagName: 'a'
  className: 'list-group-item'
  attributes: -> return { href: '#devices/' + @model.id }

# # # # #

class DeviceList extends Marionette.CollectionView
  tagName: 'ul'
  className: 'list-group'
  childView: DeviceChild

# # # # #

class DeviceListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=devices]'

  onRender: ->
    @listRegion.show new DeviceList({ collection: @collection })

# # # # #

module.exports = DeviceListLayout
