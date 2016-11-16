
class KeyboardInterface extends require './abstractInterface'
  template: require './templates/keyboard'

  events:
    'input [name=keyboard]': 'onKeyTyped'

  onKeyTyped: (e) ->
    el    = @$(e.currentTarget)
    str   = el.val()
    char  = str[str.length-1]
    # el.val('')
    window.device.writeChar(char) # TODO - remove window.device

  onRender: ->
    if @options.interface == 'keyboard'
      setTimeout( =>
        @$('input').focus()
      , 500 )

# # # # #

module.exports = KeyboardInterface
