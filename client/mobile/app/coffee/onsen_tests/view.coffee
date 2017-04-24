

# TODO - this should be abstracted into an onsenView
class OnsenLayout extends Marionette.LayoutView
  template: require './template'

  # tagName must be template
  tagName: 'ons-template'

  elName: '#carousel'

  # Does it need an ID?
  # attributes:
  #   id: 'onsen-layout'

  # el: '#carousel'
  # template: false

  events:
    'click .send': 'onSend'

  onRender: ->
    console.log 'RENDERD'
    # @setElement('#carousel')

  onSend: ->
    console.log 'ON SEND!!!!'

# # # # #

module.exports = OnsenLayout
