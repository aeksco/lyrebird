
class AppLayout extends Marionette.LayoutView
  el: 'body'

  regions:
    main: '[data-region=main]'

# # # # #

layout = new AppLayout()
module.exports = layout.main
