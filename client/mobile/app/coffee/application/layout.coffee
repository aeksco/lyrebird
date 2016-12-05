
# ApplicationLayout class definition
# Defines a Marionette.LayoutView to manage
# top-level application regions
class AppLayout extends Marionette.LayoutView
  el: 'body'

  template: false

  regions:
    mainRegion:
      selector:     '[data-region=main]'
      regionClass:  require './regions/animatedRegion'

    modalRegion:
      selector:     '[data-region=modal]'
      regionClass:  require './regions/modalRegion'

    flashRegion:    '[data-region=flash]'
    overlayRegion:  '[data-region=overlay]'
    sidebarRegion:  '[data-region=sidebar]'

# # # # #

module.exports = new AppLayout().render()
