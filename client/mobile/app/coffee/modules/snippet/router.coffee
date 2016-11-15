Service = require './service'
ListRoute = require './list/route'
NewRoute = require './new/route'
ShowRoute = require './show/route'
EditRoute = require './edit/route'

# # # # #

class SnippetRouter extends Backbone.Routing.Router

  routes:
    'snippets(/)':           'list'
    'snippets/new(/)':       'new'
    'snippets/:id(/)':       'show'
    'snippets/:id/edit(/)':  'edit'

  list: ->
    new ListRoute({ container: window.Container })

  new: ->
    new NewRoute({ container: window.Container })

  show: (id) ->
    new ShowRoute({ container: window.Container, id: id })

  edit: (id) ->
    new EditRoute({ container: window.Container, id: id })

# # # # #

module.exports = new SnippetRouter()
