
# ConfirmationsBehavior definition
# Used to manage basic confirmable views inside the application
# The 'Logout' button and 'Destroy' buttons use this Behavior to confirm
class ConfirmationsBehavior extends Marionette.Behavior

  # @ui.confirmationTrigger is defined in the views
  # that use this behavior
  events:
    'click @ui.confirmationTrigger': 'showConfirmation'

  # Fires off confirm request to Confirmation Service
  # Invokes callbackes on the view via the 'triggerMethod' helper
  showConfirmation: (e) ->
    e.stopPropagation()
    Backbone.Radio.channel('confirm').request('show', @options).then (confirmView) =>
      confirmView.on 'confirmed', => @view.triggerMethod('confirmed')
      confirmView.on 'denied',    => @view.triggerMethod('denied')

# # # # #

module.exports = ConfirmationsBehavior
