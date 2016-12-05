
# KeyClickBehavior class definition
# Provides an abstracted interface for sending keystrokes in the app.
class KeyClickBehavior extends Marionette.Behavior

  ui:
    'key': '[data-keycode]'

  events:
    'click @ui.key': 'onKeyClicked'

  onKeyClicked: (e) ->
    keycode = @$(e.currentTarget).data('keycode')
    window.device.writeChar(keycode) # TODO - remove window.device

# # # # #

module.exports = KeyClickBehavior
