
# TODO - this should be abstracted into an onsenView
class OnsenLayout extends Marionette.LayoutView
  template: require './template'
  tagName: 'ons-page'

  ui:
    send: '.send'

  events:
    'click @ui.send': 'onSend'


  onSend: ->
    console.log 'SEND: ', @$('#keyboard').val()

# # # # #

module.exports = OnsenLayout
