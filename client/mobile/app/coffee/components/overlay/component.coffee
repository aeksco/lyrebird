
class OverlayView extends Marionette.LayoutView
  template: false
  className: 'overlay'

  events:
    'click': 'onClick'

  onClick: ->
    Backbone.Radio.channel('sidebar').trigger('hide')

# # # # #

class OverlayService extends Marionette.Service

  radioEvents:
    'sidebar initialize': 'activate'

  activate: ->
    @options.container.show new OverlayView()

# # # # #

module.exports = new OverlayService({ container: window.Layout.overlayRegion })
