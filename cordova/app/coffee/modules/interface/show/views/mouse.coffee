
class MouseInterface extends require './abstractInterface'
  template: require './templates/mouse'

  events:
    'touchstart canvas':  'onTouchStart'
    'touchmove canvas':   'onTouchMove'

  onTouchStart: (e) ->
    console.log 'onTouchStart'

  onTouchMove: (e) ->
    evt = e.originalEvent

    if evt.touches && evt.touches.length == 1 # Only deal with one finger
      touch   = evt.touches[0] # Get the information for finger #1
      touchX  = touch.pageX-touch.target.offsetLeft
      touchY  = touch.pageY-touch.target.offsetTop

      mousePos = { x: touchX, y: touchY }
      message = 'Mouse position: ' + Math.round(mousePos.x) + ',' + Math.round(mousePos.y)
      $('.position').text(message)
      return

# # # # #

module.exports = MouseInterface
