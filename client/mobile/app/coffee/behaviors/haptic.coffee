
# HapticBehavior definition
# Triggers haptic and acoustic feedback on mobile devices
# for UI elements with the [data-haptic] attribute defined
class HapticBehavior extends Marionette.Behavior

  ui:
    'hapticInput': '[data-haptic]'

  events:
    'click @ui.hapticInput': 'onHapticClick'

  # Uses the [device-feedback](https://github.com/VVelda/device-feedback) Cordova plugin.
  onHapticClick: ->
    plugins?.deviceFeedback.haptic()
    plugins?.deviceFeedback.acoustic()

# # # # #

module.exports = HapticBehavior
