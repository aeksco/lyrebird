Marionette = require 'backbone.marionette'
_ = require 'underscore'

# # # # #

stillAnimating = false

class SwapView extends Marionette.LayoutView
  template: require './swap'
  className: 'swap-wrapper'

  ui:
    slot0: '[data-swap=one]'
    slot1: '[data-swap=two]'

  regions:
    slot0: '[data-swap=one]'
    slot1: '[data-swap=two]'

  # Maintains state of currentSlot
  currentSlot: 0

  # Holds queued view and options until unresolved animations are finished.
  queued: null

  templateHelpers: ->
    return { animation: @options.animation || 'up-down' }

  showQueued: ->
    return unless @queued
    view    = @queued.view
    options = @queued.options
    @queued = null
    @swap(view, options)

  swap: (view, options={}) ->

    # Queues if currently animating between two views
    if stillAnimating && @slot0.currentView && @slot1.currentView
      @queued = { view: view, options: options }
      return @["slot#{@currentSlot}"]

    # Gets next slot
    nextSlotNum = (@currentSlot+1)%2

    # Assigns slots and UI elements
    prevSlot = @["slot#{@currentSlot}"]
    nextSlot = @["slot#{nextSlotNum}"]
    prevUI = @ui["slot#{@currentSlot}"]
    nextUI = @ui["slot#{nextSlotNum}"]

    # Sets current slot
    @currentSlot = nextSlotNum

    # Starts animating
    # Anything past this point gets queued
    stillAnimating = true
    $('html').css({ overflow: 'hidden' })

    # Kicks off animation
    animation = options.animation || @options.animation || 'up-down'
    prevUI.addClass("#{animation} leaving")
    nextUI.addClass("#{animation} coming")

    # Shows new view
    nextUI.addClass('first') unless prevSlot.currentView
    nextSlot.show(view, options)

    animate = =>
      # Trigger onAnimationDone callback on view
      view.triggerMethod('animation:done')

      # Post-animate CSS maintenance
      $('html').css({ overflow: 'auto' })
      prevUI.addClass('out').removeClass("#{animation} in coming first leaving")
      nextUI.addClass('in').removeClass("#{animation} out coming first leaving")

      # Empties old view and sets state
      prevSlot.empty()
      stillAnimating = false

      # Shows any views queued during animation
      @showQueued()

    # Animates view
    setTimeout(animate, 500)

# # # # #

class SwapRegion extends Marionette.Region

  initialize: (options) ->

    # Declares throttled swap method
    swapFuncion = (view, options) =>
      return @swapView.swap(view, options)
    @swap = _.throttle( swapFuncion, 250 )

  show: (view, options={}) ->

    # Swap in new view
    return @swap(view, options) if @swapView

    # If @swapView isn't defined, instantiate it and
    @swapView = new SwapView({ animation: @options.animation })
    @swapView.on 'show', => @swap(view, options)
    super(@swapView, options)

# # # # #

module.exports = SwapRegion
