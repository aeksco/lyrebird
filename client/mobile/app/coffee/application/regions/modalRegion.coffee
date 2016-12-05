
# ModalRegion class definition
# The ModalRegion class shims the default Marionette.Region
# to destroy a view once the modal window has been hidden.
# This prevents the view being destroyed while the modal window is animating out.
class ModalRegion extends Marionette.Region

  show: (view, options = {}) ->
    view.on 'hidden:modal', -> @destroy() # ModalView garbage collection
    super(view, options)

# # # # #

module.exports = ModalRegion
