
class AppLayout extends Marionette.LayoutView
  el: 'body'

  template: false

  regions:
    main:
      selector:     '[data-region=main]'
      regionClass:  require './regions/animatedRegion'
      inAnimation:  'fadeInUp'
      outAnimation: 'fadeOutDown'

    flash:    '[data-region=flash]'
    overlay:  '[data-region=overlay]'
    sidebar:  '[data-region=sidebar]'

# # # # #

# layout = new AppLayout().render()
module.exports = new AppLayout().render()
