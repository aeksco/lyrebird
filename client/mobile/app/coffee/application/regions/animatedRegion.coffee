
stillAnimating = false

# SwapView class definition
# The SwapView is a Marionette.LayoutView that animates a transition
# between its two regions. It is used exclusively by the SwapRegion class,
# though conceivably it could be used elsewhere without issue/
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

  # Shows last view added to @queue
  showQueued: ->
    return unless @queued
    view    = @queued.view
    options = @queued.options
    @queued = null
    @swap(view, options)

  # Swaps the two regions using a custom CSS animation
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

    # Animates the view transition
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

# SwapRegion class definition
# The SwapRegion shims the default Marionette.Region class definition
# to interface with a specialized view (SwapView) to gracefully
# animate between two different views
class SwapRegion extends Marionette.Region

  initialize: (options) ->

    # Declares throttled swap method
    swapFuncion = (view, options) =>
      return @swapView.swap(view, options)
    @swap = _.throttle( swapFuncion, 250 )

  # Overwrites Marionette.Region.prototype.show()
  show: (view, options={}) ->

    # Swap in new view
    return @swap(view, options) if @swapView

    # If @swapView isn't defined, instantiate it and
    @swapView = new SwapView({ animation: @options.animation })
    @swapView.on 'show', => @swap(view, options)

    # Invokes Marionette.Region.prototype.show()
    super(@swapView, options)

# # # # #

module.exports = SwapRegion
