
class AppLayout extends Marionette.LayoutView
  el: 'body'

  template: false

  regions:
    main:
      selector:     '[data-region=main]'
      regionClass:  require './regions/animatedRegion'

    modal:
      selector:     '[data-region=modal]'
      regionClass:  require './regions/modalRegion'

    flash:    '[data-region=flash]'
    overlay:  '[data-region=overlay]'
    sidebar:  '[data-region=sidebar]'

# # # # #

module.exports = new AppLayout().render()
