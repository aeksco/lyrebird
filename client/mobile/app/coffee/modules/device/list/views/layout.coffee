
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
    refresh: '[data-pull=refresh]'

  events:
    'changestate @ui.refresh': 'onPull'

  onPull: (e) ->
    state = e.originalEvent.state

    switch state
      when 'initial'
        message = 'Pull to refresh'

      when 'preaction'
        message = 'Release'

      when 'action'
        message = 'Loading...'

    # @ui.refresh.html(message)
    # pullHook.innerHTML = message
    # @ui.refresh.get(0).innerHTML = message

  onRender: ->
    @listRegion.show new DeviceList({ collection: @collection })
    setTimeout( @initPullHook, 500)

  initPullHook: =>
    @ui.refresh.get(0)._show() # TODO - why does this have to be invoked manually?
    @ui.refresh.get(0).onAction = (done) ->
      Backbone.Radio.channel('device').trigger('refresh')
      return setTimeout(done, 1000)

# # # # #

module.exports = DeviceListLayout
