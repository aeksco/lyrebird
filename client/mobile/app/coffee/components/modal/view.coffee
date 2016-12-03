
# ModalView class definition
# Provides a generic view and region into which
# other views can conveniently be displayed in a modal
class ModalView extends Marionette.LayoutView
  template: require './modal_template'

  attributes:
    role:     'dialog'
    tabindex: '-1'

  className: 'modal fade'

  # Sets modal size - normal / small / large
  templateHelpers: ->
    size = @options.size || ''
    css = 'modal-dialog'
    css += ' modal-sm' if size == 'small'
    css += ' modal-lg' if size == 'large'
    return { modalCss: css }

  regions:
    contentRegion: '[data-region=modal-content]'

  events:
    'show.bs.modal'   : -> @triggerMethod 'show:modal'
    'shown.bs.modal'  : -> @triggerMethod 'shown:modal'
    'hide.bs.modal'   : -> @triggerMethod 'hide:modal'
    'hidden.bs.modal' : -> @triggerMethod 'hidden:modal'
    'loaded.bs.modal' : -> @triggerMethod 'loaded:modal'

  onShow: ->
    @$el.modal( @options.modalOptions || {} )

  hideModal: ->
    @$el.modal('hide')

# # # # #

module.exports = ModalView
