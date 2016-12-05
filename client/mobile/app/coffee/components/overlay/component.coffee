
# OverlayView class definition
# Prevents user interactions when sidebar is engaged
# And closes sidebar on click
class OverlayView extends Marionette.LayoutView
  template: false
  className: 'overlay'

  events:
    'click': 'onClick'

  onClick: ->
    Backbone.Radio.channel('sidebar').trigger('hide')

# # # # #

# OverlayService class definition
# Renders a transparent overlay when the sidebar is engaged
class OverlayService extends Marionette.Service

  radioEvents:
    'sidebar initialize': 'activate'

  activate: ->
    @options.container.show new OverlayView()

# # # # #

module.exports = new OverlayService({ container: window.Layout.overlayRegion })
