
class AppLayout extends Marionette.LayoutView
  el: 'body'

  regions:
    main:
      selector:     '[data-region=main]'
      regionClass:  require './regions/animatedRegion'
      inAnimation:  'fadeInUp'
      outAnimation: 'fadeOutDown'

    flash:    '[data-region=flash]'
    sidebar:  '[data-region=sidebar]'

# # # # #

layout = new AppLayout()
module.exports = layout
