
class LayoutView extends Marionette.LayoutView
  el: 'body'

  regions:
    main: '[data-region=main]'

layout = new LayoutView()
module.exports = layout.main
