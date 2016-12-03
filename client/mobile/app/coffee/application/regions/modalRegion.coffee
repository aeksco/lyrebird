
class ModalRegion extends Marionette.Region

  show: (view, options = {}) ->
    view.on 'hidden:modal', -> @destroy() # ModalView garbage collection
    super(view, options)

# # # # #

module.exports = ModalRegion
