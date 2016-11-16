
class MouseInterface extends require './abstractInterface'
  template: require './templates/mouse'

  events:
    'touchstart canvas':  'onTouchStart'
    'touchmove canvas':   'onTouchMove'
    'click [data-mouse]': 'onMouseClick'

  onMouseClick: (e) ->
    el = $(e.currentTarget)
    clicked = el.data('mouse')
    console.log 'SEND MOUSE CLICK?: ', clicked

  onTouchStart: (e) ->
    console.log 'onTouchStart'

  onTouchMove: (e) ->
    evt = e.originalEvent

    return unless evt.touches

    # Two-finger scroll
    if evt.touches.length == 2 # Only deal with one finger
      mode = 'Scroll to: '

    # Mose move
    else
      mode = 'Move to: '

    # Gets position
    touch   = evt.touches[0] # Get the information for finger #1
    touchX  = touch.pageX-touch.target.offsetLeft
    touchY  = touch.pageY-touch.target.offsetTop

    # Outputs position
    mousePos = { x: touchX, y: touchY }
    message = mode + Math.round(mousePos.x) + ',' + Math.round(mousePos.y)
    $('.position').text(message)
    return

# # # # #

module.exports = MouseInterface
