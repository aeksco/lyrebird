Mouse     = require './mouse'
Keyboard  = require './keyboard'
Remote    = require './remote'
Numpad    = require './numpad'
Chrome    = require './chrome'
# Gamepad   = require './gamepad'

# # # # #

class InterfaceSlider extends Marionette.LayoutView
  template: require './templates/all'
  className: 'container-fluid'

  regions:
    interfaceRegion:
      selector: '[data-region=interface]'
      regionClass: require '../../../../application/regions/animatedRegion'
      animation: 'right-in'

  views:
    keyboard: Keyboard
    mouse:    Mouse
    remote:   Remote
    numpad:   Numpad
    chrome:   Chrome

  indexMap:
    0: 'keyboard'
    1: 'mouse'
    2: 'remote'
    3: 'numpad'
    4: 'chrome'
    # 4: 'gamepad'

  getViewByIndex: (index) ->
    return @views[@indexMap[index]]

  onRender: ->
    View = @views[@options.type]
    @interfaceRegion.show(new View(), {animation: 'right-in'})
    setTimeout( @initSwiper, 10)

  initSwiper: =>

    # Initializes Swiper
    @swiper = new Swiper('.interfaces', {
      speed: 300
      onSlideChangeStart: @onSlideChangeEnd
    })

  onBeforeDestroy: =>
    @swiper.destroy(true, true)

  onSlideChangeEnd: (swiper) =>
    @showInterface(swiper.snapIndex)

  lastIndex: 0
  showInterface: (index) =>
    if index > @lastIndex
      animation = 'right-in'
    else
      animation = 'left-in'

    @lastIndex = index
    View = @getViewByIndex(index)
    @interfaceRegion.show(new View(), { animation: animation })


# # # # #

module.exports = InterfaceSlider
