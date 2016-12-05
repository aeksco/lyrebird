
# AbstractInterfaceView class definition
# Defines a Marionette.LayoutView that serves as the abstract superclass
# from which all other interface views are extended.
class AbstractInterfaceView extends Marionette.LayoutView
  template: null
  className: 'row'

  behaviors:
    Haptic: {}
    KeyClick: {}

  # FEATURE - insomnia timeout should be managed in user settings

  # Insomnia plugin ensures that phone screen
  # does not turn off when an interface is open
  initialize: ->
    plugins?.insomnia.keepAwake()

  onDestroy: ->
    plugins?.insomnia.allowSleepAgain()

# # # # #

module.exports = AbstractInterfaceView
