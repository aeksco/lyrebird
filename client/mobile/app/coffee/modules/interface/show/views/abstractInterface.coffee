
class AbstractInterfaceView extends Marionette.LayoutView
  template: null
  className: 'row'

  behaviors:
    Haptic: {}
    KeyClick: {}

  # FEATURE - insomnia timeout should be managed in user settings
  initialize: ->
    plugins?.insomnia.keepAwake()

  onDestroy: ->
    plugins?.insomnia.allowSleepAgain()

# # # # #

module.exports = AbstractInterfaceView
