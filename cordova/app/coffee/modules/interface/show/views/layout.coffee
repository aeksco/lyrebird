
# TODO - this should be an abstract Interface view class
class AbstractInterfaceView extends Marionette.LayoutView
  className: 'container-fluid'

  behaviors:
    Haptic: {}

  template: =>
    interfaceId = @options.interface

    switch interfaceId
      when 'keyboard' then  return require './templates/keyboard'
      when 'remote'   then  return require './templates/remote'
      when 'gamepad'  then  return require './templates/gamepad'
      else                  return require './templates/layout'

  events:
    'click [data-keycode]':     'onKeyClicked'
    'input [name=keyboard]':    'onKeyTyped'

  onKeyClicked: (e) ->
    console.log 'SEND KEYCODE: ', @$(e.currentTarget).data('keycode')

  onKeyTyped: (e) ->
    str = $(e.currentTarget).val()
    char = str[str.length-1]
    console.log 'SEND CHAR: ', char

  onRender: ->
    if @options.interface == 'keyboard'
      setTimeout( =>
        @$('input').focus()
      , 500 )

# # # # #

module.exports = AbstractInterfaceView
