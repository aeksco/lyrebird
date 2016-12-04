Mouse     = require './mouse'
Keyboard  = require './keyboard'
Remote    = require './remote'
Numpad    = require './Numpad'
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

  indexMap:
    0: 'keyboard'
    1: 'mouse'
    2: 'remote'
    3: 'numpad'
    # 4: 'gamepad'

  getViewByIndex: (index) ->
    return @views[@indexMap[index]]

  onRender: ->
    View = @views[@options.type]
    @interfaceRegion.show(new View(), {animation: 'right-in'})
    setTimeout( @initSwiper, 10)

  initSwiper: =>

    # Sets initial slider state from @options.type
    # TODO - this gets invoked twice.
    # onInit = (swiper) =>
    #   @indexByView ||= _.invert(@indexMap)
    #   @lastIndex = @indexByView[@options.type]
    #   swiper?.slideTo(@lastIndex, null, false)

    @swiper = new Swiper('.interfaces', {
      # onInit:           onInit
      onSlideChangeEnd: @onSlideChangeEnd
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
