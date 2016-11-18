
sendCommand = (pos) ->
  console.log 'SEND COMMAND'
  window.device.writeMouse(pos)

throttledCommand = _.throttle(sendCommand, 50)

# # # # #
class MouseInterface extends require './abstractInterface'
  template: require './templates/mouse'

  events:
    'touchstart canvas':  'onTouchStart'
    'touchmove canvas':   'onTouchMove'
    'click [data-mouse]': 'onMouseClick'

  mousePos:
    x: 0
    y: 0

  onMouseClick: (e) ->
    el = $(e.currentTarget)
    clicked = el.data('mouse')
    console.log 'SEND MOUSE CLICK?: ', clicked

  onTouchStart: (e) ->
    # console.log 'onTouchStart'

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

    # Old mouse position
    @oldPos = _.clone(@newPos)
    @newPos = {x: touchX, y: touchY}

    # console.log @oldPos
    # console.log @newPos

    # New mouse position
    @deltaPos = { x: Math.round(@newPos.x - @oldPos.x), y: Math.round(@newPos.y - @oldPos.y) }
    @deltaPos.x = 5*@deltaPos.x
    @deltaPos.y = 5*@deltaPos.y

    # console.log @deltaPos

    # Sends mouse DX,DY to device
    throttledCommand(@deltaPos)

    # Outputs position
    message = mode + Math.round(@deltaPos.x) + ',' + Math.round(@deltaPos.y)
    $('.position').text(message)
    return

# # # # #

module.exports = MouseInterface
