
# TODO - this should be abstracted into an onsenView
class AppLayout extends Marionette.LayoutView
  template: require './layout'

  # tagName must be template
  tagName: 'ons-template'

  # Does it need an ID?
  attributes:
    id: 'onsen-layout'

  regions:
    layoutRegion: '[data-region=layout]'

  onRender: ->
    console.log 'RENDERD LAYOUT'
    # @setElement('#carousel')

# # # # #

module.exports = AppLayout
