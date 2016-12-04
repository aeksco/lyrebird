Mouse     = require './mouse'
Keyboard  = require './keyboard'
Remote    = require './remote'
Gamepad   = require './gamepad'
Numpad    = require './Numpad'

# # # # #

class InterfaceSlider extends require './abstractInterface'
  template: require './templates/all'

  regions:
    interfaceRegion:
      selector: '[data-region=interface]'
      regionClass: require '../../../../application/regions/animatedRegion'
      animation: 'right-in'

  viewByIndex:
    0: Keyboard
    1: Mouse
    2: Remote
    3: Numpad
    4: Gamepad

  onRender: ->
    @interfaceRegion.show(new Keyboard(), {animation: 'right-in'})
    setTimeout( @initSwiper, 1000)

  initSwiper: =>
    new Swiper('.interfaces', {
      # loop: true
      onSlideChangeEnd: @onSlideChangeEnd
    })

  onSlideChangeEnd: (swiper) =>
    @showInterface(swiper.snapIndex)

  # flag: true
  lastIndex: 0
  showInterface: (index) =>
    # return @flag = false if @flag

    # Non-zero bug
    # index = 1 if index == 0

    if index > @lastIndex
      animation = 'right-in'
    else
      animation = 'left-in'

    @lastIndex = index
    View = @viewByIndex[index]
    console.log index
    console.log View
    @interfaceRegion.show(new View(), { animation: animation })


# # # # #

module.exports = InterfaceSlider
