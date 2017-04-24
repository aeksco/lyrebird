
# DeviceEmpty class definition
# Defines a Marionette.LayoutView that's shown
# when no Lyrebird devices are detected
class DeviceEmpty extends Marionette.LayoutView
  template: require './templates/empty'
  tagName: 'ons-list-item'

# # # # #

# DeviceChild class definition
# Defines a Marionette.LayoutView to display
# a single detected Lyrebird devices
class DeviceChild extends Marionette.LayoutView
  template: require './templates/child'
  tagName: 'ons-list-item'

  events:
    'click': 'onClick'

  onClick: ->
    window.fn.load('device:show', @model.id)

# # # # #

# DeviceList class definition
# Defines a Marionette.LayoutView to show a DeviceChild
# view instance for each Lyrebird device detected, or display a
# DeviceEmpty view instance when no devices are detected.
class DeviceList extends Marionette.CollectionView
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

  tagName: 'ons-page'

  regions:
    listRegion: '[data-region=list]'

  ui:
    refresh: '[data-click=refresh]'

  events:
    'click @ui.refresh': 'refreshDevices'
    'click .interfaces': 'interfaces'

  onRender: ->
    @listRegion.show new DeviceList({ collection: @collection })

  interfaces: ->
    window.location.href = '#interface'

  refreshDevices: ->
    Backbone.Radio.channel('device').trigger('refresh')

# # # # #

module.exports = DeviceListLayout
