
class DeviceEmpty extends Marionette.LayoutView
  template: require './templates/empty'
  className: 'list-group-item list-group-item-warning'
  tagName: 'li'

# # # # #

class DeviceChild extends Marionette.LayoutView
  template: require './templates/child'
  className: 'list-group-item'
  tagName: 'a'

  attributes: ->
    return { href: '#devices/' + @model.id }

# # # # #

class DeviceList extends Marionette.CollectionView
  className: 'list-group'
  tagName: 'ul'
  childView: DeviceChild
  emptyView: DeviceEmpty

# # # # #

class DeviceListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'

  ui:
    refresh: '[data-click=refresh]'

  events:
    'click @ui.refresh': 'refreshDevices'

  onRender: ->
    @listRegion.show new DeviceList({ collection: @collection })

  refreshDevices: ->
    Backbone.Radio.channel('device').trigger('refresh')

# # # # #

module.exports = DeviceListLayout
