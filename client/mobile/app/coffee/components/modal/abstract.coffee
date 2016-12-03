ModalView = require './view'

# # # # #

# Window event listener to hide the modal when navigation occurs.
hideModalOnHashChange = -> window.modalWindow.hideModal()

# Abstract class for modal-based components.
class AbstractModalComponent extends Marionette.Service

  initialize: (options = {}) ->
    @container = options.container

  hideModal: ->
    @modalView.hideModal()

  showModal: (contentView, modalViewOptions={}) ->

      # New Modal View (our view is shown inside this one)
      @modalView = new ModalView(modalViewOptions)

      # Show the view inside the modal wrapper, adds hideModalOnHashChange event listener
      @modalView.on 'show', =>
        @modalView.contentRegion.show( contentView )
        window.addEventListener('hashchange', hideModalOnHashChange)
        window.modalWindow = @modalView

      # Removes hideModalOnHashChange event listener
      @modalView.on 'destroy', ->
        window.removeEventListener('hashchange', hideModalOnHashChange)
        delete window.modalWindow

      # onModalHidden callback
      @modalView.on 'hidden:modal', => @onModalHidden?()

      # Show view in the modal
      @container.show @modalView

# # # # #

module.exports = AbstractModalComponent
