
class KeyboardInterface extends require './abstractInterface'
  template: require './templates/keyboard'

  events:
    'input [name=keyboard]': 'onKeyTyped'

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

module.exports = KeyboardInterface
