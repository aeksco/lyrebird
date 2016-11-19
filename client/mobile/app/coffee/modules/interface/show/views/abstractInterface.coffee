
class AbstractInterfaceView extends Marionette.LayoutView
  template: null
  className: 'container-fluid'

  behaviors:
    Haptic: {}
    KeyClick: {}

  # FEATURE - insomnia timeout can be managed in user settings
  initialize: ->
    plugins.insomnia.keepAwake()

  onDestroy: ->
    plugins.insomnia.allowSleepAgain()

# # # # #

module.exports = AbstractInterfaceView
