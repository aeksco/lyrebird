
# !!!
stillAnimating = false

class SwapView extends Marionette.LayoutView
  template: require './swap' # !!! - replace with _.template('...', [options])
  # template: _.template('<div data-region="swap-1" style="position:absolute; width:100%; animation-duration: 0.5s"></div><div data-region="swap-2" style="position:absolute; width:100%; animation-duration: 0.5s"></div>')

  attributes:
    style: 'position: relative;'

  # !!! - rename these in template
  regions:
    slot0: '[data-swap=one]'
    slot1: '[data-swap=two]'

  # Maintains state of currentSlot
  currentSlot: 0

  # !!! - this is ONLY chrome compliant now. Make sure it works well with other browsers..?
  # QUESTION - non-webkit events fire twice...? What the hell? 'webkitAnimationStart' & 'animationStart' each fire.
  # animationEnd: 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
  # animationStart: 'webkitAnimationStart mozAnimationstart MSAnimationStart oanimationstart animationstart'
  animationEnd: 'webkitAnimationEnd'
  animationStart: 'webkitAnimationStart'

  # Default animation properties
  defaults:
    inAnimation: ''   # !!! - implement
    outAnimation: ''  # !!! - implement

  # !!! - rename this?
  originalCss:
    hide:       'invis'
    base:       'animated'
    in:         ''
    out:        ''
    reverseIn:  ''
    reverseOut: ''
    remove:     ''

  # Holds queued view and options until unresolved animations are finished.
  queued: null

  initialize: (options) ->
    @buildCss()

  serializeData: ->
    { animationSpeed: @options.animationSpeed }

  # Builds the css classes that govern animations
  # !!! - clean this up - perhaps use arrays w/ .join(' ') instead of strings
  buildCss: ->
    @css              = _.clone(@originalCss)
    @css.in           += @css.base.concat(' ', @options.inAnimation)
    @css.out          += @css.base.concat(' ', @options.outAnimation)
    @css.reverseIn    += @css.base.concat(' ', @options.outAnimation.replace('Out', 'In') )
    @css.reverseOut   += @css.base.concat(' ', @options.inAnimation.replace('In', 'Out') )
    @css.remove       += @css.base.concat(' ', @options.outAnimation, ' ', @options.inAnimation, ' ', @css.reverseIn, ' ', @css.reverseOut)

  showQueued: ->
    return unless @queued
    # console.log 'show queued: ', @queued.view._listenId
    view    = @queued.view
    options = @queued.options
    @queued = null
    @swap(view, options)

  # !!! - throttle swap requests
  swap: (view, options={}) ->

    if stillAnimating && @slot0.currentView && @slot1.currentView
      # console.log 'adding to queue: ', view._listenId
      @queued = { view: view, options: options }
      return @["slot#{@currentSlot}"]

    # # # # #
    # !!! - do we want to call these slots?
    nextSlotNum = (@currentSlot+1)%2
    prevSlot = @["slot#{@currentSlot}"]
    nextSlot = @["slot#{nextSlotNum}"]
    @currentSlot = nextSlotNum
    # # # # #

    # Animate the transition
    @parallelSwap(prevSlot, nextSlot, view, options)

  parallelSwap: (prevSlot, nextSlot, view, options) ->

    if @queued
      view    = @queued.view
      options = @queued.options
      @queued = null

    # # # # #

    # Animation events fire after 'show' event on new view
    view.on 'show', =>

      # Animate into next view IF there is no prevSlot to empty
      return @animateNext(nextSlot, options) unless prevSlot.currentView

      # PrevSlot on 'animationEnd'
      # !!! - break this into outside callback?
      prevSlot.$el.one @animationEnd, (e) =>
        e.stopPropagation()

        # Prevents scroll on animation in/out
        $('html').css({ overflow: 'auto' })

        prevSlot.empty()
        prevSlot.$el.removeClass(@css.remove).addClass(@css.hide)

      # PrevSlot on 'animationStart'
      # !!! - break this into outside callback?
      prevSlot.$el.one @animationStart, (e) =>
        e.stopPropagation()
        stillAnimating = true

        # Prevents scroll on animation in/out
        $('html').css({ overflow: 'hidden' })

        @animateNext(nextSlot, options)

      # Begins the animation
      # !!! - break this into outside callback, animatePrev, animateOut?
      cssOut = @css.out
      cssOut = @css.reverseOut if options.reverseAnimation
      prevSlot.$el.addClass(cssOut).removeClass(@css.hide)

    # # # # #

    # Shows the view in the nextSlot, kicks off animation
    nextSlot.show(view, options)

    # Maintain current Region.show() functionality
    return nextSlot

  animateNext: (nextSlot, options) ->
    # NextSlot animation callback
    nextSlot.$el.one @animationEnd, (e) =>
      e.stopPropagation()
      stillAnimating = false

      # !!! - onAnimationDone callback - not used anywhere
      # nextSlot.currentView?.triggerMethod 'animation:done'
      nextSlot.$el.removeClass(@css.remove)
      @showQueued()

    # Trigger animation
    cssIn = @css.in
    cssIn = @css.reverseIn if options.reverseAnimation

    nextSlot.$el.addClass(cssIn).removeClass(@css.hide)

# # # # #

class SwapRegion extends Marionette.Region

    # !!! - refine with default animations, or is that part of the SwapView?
    # !!! - set in initialize
    # !!! - see https://github.com/jmeas/marionette.transition-region/blob/master/marionette.transition-region.js
  initialize: ->
    @swapViewOpts =
      inAnimation:    @options.inAnimation
      outAnimation:   @options.outAnimation
      animationSpeed: @options.animationSpeed || 0.5
      series:         @options.series

    # Declares throttled swap method in lieu of more robust queing operation
    # We may want to explore a queuing algorithm at a later time
    swapFuncion = (view, options) => return @swapView.swap(view, options)
    @swap = _.throttle( swapFuncion, 250 )

  # !!! - throttle / queue show requests to prevent no-view bug
  show: (view, options={}) ->
    return @swap(view, options) if @swapView

    @swapView = new SwapView(@swapViewOpts)
    @swapView.on 'show', => @swap(view, options)
    super(@swapView, options)

  swap: ->
    return @swapView.swap(view, options) if @swapView

# # # # #

module.exports = SwapRegion
