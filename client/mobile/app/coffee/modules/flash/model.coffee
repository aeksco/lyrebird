
class FlashModel extends Backbone.Model

  defaults:
    timeout: 5000
    dismissible: true
    context: 'info'

  # Alert Model Attributes / Options
  # - message
  # - strongText (please rename to 'strong' & add appropriate spacing to template)
  # - contextClass (please rename to 'context')
  # - timeout (default is 5 seconds)
  # - dismissible (default is true)

  dismiss: ->
    @collection.remove(@)

# # # # #

module.exports = FlashModel
