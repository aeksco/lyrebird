
class OnsenRegion extends Marionette.Region

  initialize: (options) ->

    # Caches navigator element
    @navigator = document.getElementById("myNavigator")

  # Overwrites Marionette.Region.prototype.show()
  show: (view, options={}) ->

    # Swap in new view
    # return @swap(view, options) if @swapView

    # TODO - show views only
    # view.render()
    # @navigator.pushPage('foo', { pageHTML: view.$el.html() })
    # setTimeout( =>
    #   view.setElement(view.elName)
    # , 250 )
    # return view

    # If @swapView isn't defined, instantiate it and
    # @swapView = new SwapView({ animation: @options.animation })
    # @swapView.on 'show', => @swap(view, options)

    # # Invokes Marionette.Region.prototype.show()
    super(view, options)

# # # # #

module.exports = OnsenRegion
