
# TODO - this should be an abstract Interface view class
class InterfaceShowLayout extends Marionette.LayoutView
  className: 'container-fluid'

  template: =>
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
    'input [name=keyboard]': 'onKeyTyped'

  onKeyClicked: (e) ->
    console.log 'SEND KEYCODE: ', @$(e.currentTarget).data('keycode')

  onHapticClick: (e) ->
    plugins?.deviceFeedback.haptic()
    plugins?.deviceFeedback.acoustic()

  onKeyTyped: (e) ->
    str = $(e.currentTarget).val()
    char = str[str.length-1]
    console.log 'SEND CHAR: ', char

  onRender: ->
    if @options.interface == 'keyboard'
      setTimeout( =>
        @$('input').focus()
      , 500 )

    if @options.interface == 'mouse'
      setTimeout( =>
        @initMouseCanvas()
      , 500 )

  initMouseCanvas: ->
    canvas = document.getElementById('mouse-canvas')
    context = canvas.getContext('2d')

    getMousePos = (canvas, evt) ->
      rect = canvas.getBoundingClientRect()
      return { x: evt.clientX - (rect.left), y: evt.clientY - (rect.top) }

    canvas.addEventListener 'mousemove', ((evt) ->
      mousePos = getMousePos(canvas, evt)
      message = 'Mouse position: ' + mousePos.x + ',' + mousePos.y
      # console.log message
      $('.position').text(message)
      return
    ), false


# # # # #

module.exports = InterfaceShowLayout
