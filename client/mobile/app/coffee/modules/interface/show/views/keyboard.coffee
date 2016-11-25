
class KeyboardInterface extends require './abstractInterface'
  template: require './templates/keyboard'

  ui:
    send:   '[data-click=send]'
    input:  '[name=keyboard]'

  events:
    'click @ui.send': 'sendText'

  sendText: ->
    # Gets value
    text = @ui.input.val()

    # Clears input
    @ui.input.val('')

    # Sends to device
    window.device.sendText(text) # TODO - remove window.device

  onRender: -> # TODO - why isn't this working?
    if @options.interface == 'keyboard'
      setTimeout( =>
        @$('input').focus()
      , 500 )

# # # # #

module.exports = KeyboardInterface
