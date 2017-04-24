
class OnsenLayout extends Marionette.LayoutView
  template: require './templates/onsen'
  tagName: 'ons-page'

  behaviors:
    KeyClick: {}

  events:
    'touchstart canvas':  'onTouchStart'
    'touchmove canvas':   'onTouchMove'
    'click [data-mouse]': 'onMouseClick'
    'click [data-click=send]': 'onSend'

  # MOUSE
  # TODO - should be a behavior
  mousePos:
    x: 0
    y: 0

  onMouseClick: (e) ->
    clicked = $(e.currentTarget).data('mouse')

    # TODO - remove window.device
    return window.device?.clickMouseLeft() if clicked == 'left'
    return window.device?.clickMouseRight()

  onTouchStart: (e) ->
    # e.preventDefault()
    e.stopPropagation()
    evt = e.originalEvent
    return unless evt.touches
    return if evt.touches.length > 1
    touch   = evt.touches[0] # Get the information for finger #1
    touchX  = touch.pageX-touch.target.offsetLeft
    touchY  = touch.pageY-touch.target.offsetTop
    @newPos = {x: touchX, y: touchY}

    # Tap to touch
    # TODO - should be optional - where do settings get managed?
    @touchStarted = true
    setTimeout( =>
      window.device?.clickMouseLeft() if @touchStarted
    , 200)

    return

  onTouchMove: (e) ->
    # e.preventDefault()
    e.stopPropagation()
    # Prevents 'tap to click'
    @touchStarted = false

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

    # New mouse position
    scalar = 5
    @deltaPos = { x: Math.round(scalar * (@newPos.x - @oldPos.x)), y: Math.round(scalar * (@newPos.y - @oldPos.y)) }
    @deltaPos.x = @deltaPos.x
    @deltaPos.y = @deltaPos.y

    # Sends mouse DX,DY to device
    # TODO - retire window.device
    window.device?.writeMousePos(@deltaPos)

    # Outputs position
    message = mode + Math.round(@deltaPos.x) + ',' + Math.round(@deltaPos.y)
    $('.position').text(message)
    return

  # # # # #
  # End Mouse

  onSend: ->

    if window.device
      console.log 'SEND - device present'

      # Isolates input value
      text = $('#keyboard').val()

      # Sends text
      window.device?.sendText(text)

      # Clears value
      $('#keyboard').val('')

    else
      console.log 'SEND - device not present'

    return

# # # # #

module.exports = OnsenLayout
