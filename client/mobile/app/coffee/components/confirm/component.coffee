ConfirmView = require './views/confirmView'

# # # # #

# ConfirmComponent class definition
# Extends AbstractModalComponent to be used with a
# basic view that handles confirmation and denial from an end-user
class ConfirmComponent extends require '../modal/abstract'

  radioRequests:
    'confirm show': 'confirm'

  confirm: (options={}) ->
    return new Promise (resolve, reject) =>
      confirmView = new ConfirmView(options)

      # Hide on deny / confirm
      confirmView.on 'denied',    => @hideModal()
      confirmView.on 'confirmed', => @hideModal()

      # Shows view in modal
      # Accepts 'small' / 'large' for size option
      @showModal(confirmView, { size: options.size })

      # Returns confirmView
      resolve(confirmView)

# # # # #

module.exports = new ConfirmComponent({ container: window.Layout.modalRegion })
