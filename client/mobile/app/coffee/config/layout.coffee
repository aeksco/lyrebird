
class AppLayout extends Marionette.LayoutView
  el: 'body'

  regions:
    main:     '[data-region=main]'
    sidebar:  '[data-region=sidebar]'

# # # # #

layout = new AppLayout()
module.exports = layout
