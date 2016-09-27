
class InterfaceShowLayout extends Marionette.LayoutView
  className: 'container-fluid'

  template: =>
    console.log @
    console.log @options
    interfaceId = @options.interface

    switch interfaceId
      when 'keyboard' then  return require './templates/keyboard'
      when 'remote'   then  return require './templates/remote'
      when 'gamepad'  then  return require './templates/gamepad'
      when 'mouse'    then  return require './templates/mouse'
      else                  return require './templates/layout'

  events:
    'click [data-keycode]': 'onKeyClicked'
    'click [data-haptic=true]': 'onHapticClick'

  onKeyClicked: (e) ->
    console.log 'SEND KEYCODE: ', @$(e.currentTarget).data('keycode')

  onHapticClick: (e) ->
    plugins?.deviceFeedback.haptic()
    plugins?.deviceFeedback.acoustic()

# # # # #

module.exports = InterfaceShowLayout
