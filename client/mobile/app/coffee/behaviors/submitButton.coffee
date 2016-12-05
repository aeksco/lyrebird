
# SubmitButtonBehavior class definition
# Provides an event listener and handler, and defines
# associated callbacks on the view to which the behavior
# is attached. This is used in all form views.
class SubmitButtonBehavior extends Marionette.Behavior

  ui:
    submit: '[data-click=submit]'

  events:
    'click @ui.submit:not(.disabled)': 'onSubmitClick'

  initialize: (options={}) ->
    @view.disableSubmit = => @disableSubmit()
    @view.enableSubmit  = => @enableSubmit()

  onSubmitClick: (e) -> @view.onSubmit?(e)
  disableSubmit: -> @ui.submit.addClass('disabled')
  enableSubmit: ->  @ui.submit.removeClass('disabled')

# # # # #

module.exports = SubmitButtonBehavior
