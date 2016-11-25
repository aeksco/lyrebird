
class FlashChild extends Marionette.LayoutView
  className: 'row'
  template: require './templates/flash_child'

  attributes:
    style: 'display:none;'

  ui:
    close: '[data-click=dismiss]'

  events:
    'click @ui.close': 'dismiss'

  onShow: ->
    timeout = @model.get('timeout')
    setTimeout( @dismiss, timeout )

  onAttach: ->
    @$el.fadeIn()

  remove: ->
    @$el.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', => Marionette.LayoutView.prototype.remove.call(@) )
    @$el.slideToggle().addClass('animated fadeOutRight')

  dismiss: =>
    @model.collection?.remove( @model ) # QUESTION - is this memory safe?

# # # # #

class FlashList extends Marionette.CollectionView
  className: 'container-fluid'
  childView: FlashChild

# # # # #

module.exports = FlashList
