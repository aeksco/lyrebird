
class AbstractInterfaceView extends Marionette.LayoutView
  template: null
  className: 'container-fluid'

  behaviors:
    Haptic: {}

  events:
    'click [data-keycode]': 'onKeyClicked'

  onKeyClicked: (e) ->
    console.log 'SEND KEYCODE: ', @$(e.currentTarget).data('keycode')

# # # # #

module.exports = AbstractInterfaceView
