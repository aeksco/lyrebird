
class MouseInterface extends require './layout'
  template: require './templates/mouse'

  onRender: ->
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

module.exports = MouseInterface
