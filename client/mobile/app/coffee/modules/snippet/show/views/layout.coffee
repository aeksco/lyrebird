
# SnippetShowLayout class definition
# Defines a Marionette.LayoutView class to display a snippet
# Includes controls to Edit & Destroy the snippet (TODO)
class SnippetShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  ui:
    send: '[data-click=send]'
    confirmationTrigger: '[data-click=confirm]'

  # TODO - destroy model
  # TODO - send behavior
  # TODO - destroy model behavior

  behaviors:
    Confirmations:
      message:      'Are you sure you want to confirm?'
      confirmIcon:  'fa-times'
      confirmText:  'Confirm?'
      confirmCss:   'btn-danger'

  events:
    'click @ui.send': 'sendText'

  onConfirmed: ->
    console.log 'ON CONFIRM'

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    return data

  sendText: ->
    text = @model.get('snippet')
    window.device.sendText(text)

# # # # #

module.exports = SnippetShowLayout
