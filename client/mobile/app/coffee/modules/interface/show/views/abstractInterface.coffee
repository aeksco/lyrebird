
class AbstractInterfaceView extends Marionette.LayoutView
  template: null
  className: 'container-fluid'

  behaviors:
    Haptic: {}
    KeyClick: {}

  initialize: ->
    plugins.insomnia.keepAwake()

  onDestroy: ->
    plugins.insomnia.allowSleepAgain()

# # # # #

module.exports = AbstractInterfaceView
