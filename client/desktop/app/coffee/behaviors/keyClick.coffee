
class KeyClickBehavior extends Marionette.Behavior

  ui:
    'key': '[data-keycode]'

  events:
    'click @ui.key': 'onKeyClicked'

  onKeyClicked: (e) ->
    console.log 'SEND KEYCODE: ', @$(e.currentTarget).data('keycode')

# # # # #

module.exports = KeyClickBehavior
