
class SnippetShowLayout extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  # TODO - destroy model
  # TODO - send behavior
  # TODO - destroy model behavior
  ui:
    send: '[data-click=send]'

  events:
    'click @ui.send': 'sendText'

  serializeData: ->
    data = super
    data.json = JSON.stringify(@model.toJSON(), null, 2).split("\n")
    return data

  sendText: ->
    text = @model.get('snippet')
    window.device.sendText(text)

# # # # #

module.exports = SnippetShowLayout
