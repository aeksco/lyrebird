
class OnsenRegion extends Marionette.Region

  initialize: (options) ->

    # Caches navigator element
    @navigator = document.getElementById("myNavigator")

  # Overwrites Marionette.Region.prototype.show()
  show: (view, options={}) ->

    # Swap in new view
    # return @swap(view, options) if @swapView

    view.render()
    @navigator.pushPage('foo', { pageHTML: view.$el.html() })
    return view

    # If @swapView isn't defined, instantiate it and
    # @swapView = new SwapView({ animation: @options.animation })
    # @swapView.on 'show', => @swap(view, options)

    # # Invokes Marionette.Region.prototype.show()
    # super(@swapView, options)

# # # # #

module.exports = OnsenRegion
