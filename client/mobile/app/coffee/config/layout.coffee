
class AppLayout extends Marionette.LayoutView
  el: 'body'

  regions:
    main:     '[data-region=main]'
    flash:    '[data-region=flash]'
    sidebar:  '[data-region=sidebar]'

# # # # #

layout = new AppLayout()
module.exports = layout
