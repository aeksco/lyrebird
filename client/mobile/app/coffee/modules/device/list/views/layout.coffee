
# DeviceEmpty class definition
# Defines a Marionette.LayoutView that's shown
# when no Lyrebird devices are detected
class DeviceEmpty extends Marionette.LayoutView
  template: require './templates/empty'
  # className: 'list-group-item list-group-item-warning'
  # tagName: 'li'
  tagName: 'ons-list-item'

# # # # #

# DeviceChild class definition
# Defines a Marionette.LayoutView to display
# a single detected Lyrebird devices
class DeviceChild extends Marionette.LayoutView
  template: require './templates/child'
  # className: 'list-group-item'
  # tagName: 'a'
  tagName: 'ons-list-item'

  attributes: ->
    return { href: '#devices/' + @model.id }

# # # # #

# DeviceList class definition
# Defines a Marionette.LayoutView to show a DeviceChild
# view instance for each Lyrebird device detected, or display a
# DeviceEmpty view instance when no devices are detected.
class DeviceList extends Marionette.CollectionView
  # className: 'list-group'
  # tagName: 'ul'
  tagName: 'ons-list'
  childView: DeviceChild
  emptyView: DeviceEmpty

# # # # #

# DeviceListLayout class definition
# Defines a Marionette.LayoutView in which the DeviceList is
# shown. This view also has a button that can trigger a refresh
# to scan for new devices.
class DeviceListLayout extends Marionette.LayoutView
  template: require './templates/layout'
  # className: 'container-fluid'

  tagName: 'ons-template'

  regions:
    listRegion: '[data-region=list]'

  ui:
    refresh: '[data-click=refresh]'

  events:
    'click @ui.refresh': 'refreshDevices'

  onRender: ->
    @listRegion.show new DeviceList({ collection: @collection })

  refreshDevices: ->
    console.log 'REFRESH DEVICES'
    Backbone.Radio.channel('device').trigger('refresh')

# # # # #

module.exports = DeviceListLayout
