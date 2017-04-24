Service = require './service'
ListRoute = require './modules/snippet/list/route'
NewRoute = require './modules/snippet/new/route'
ShowRoute = require './modules/snippet/show/route'
EditRoute = require './modules/snippet/edit/route'

# # # # #

# SnippetRouter class definition
class SnippetRouter extends require '../base/router'

  routes:
    'snippets(/)':           'list'
    'snippets/new(/)':       'new'
    'snippets/:id(/)':       'show'
    'snippets/:id/edit(/)':  'edit'

  list: ->
    new ListRoute({ container: @container })

  new: ->
    new NewRoute({ container: @container })

  show: (id) ->
    new ShowRoute({ container: @container, id: id })

  edit: (id) ->
    new EditRoute({ container: @container, id: id })

# # # # #

module.exports = new SnippetRouter({ container: window.Layout.mainRegion })
