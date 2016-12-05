Service = require './service'
ListRoute = require './list/route'
NewRoute = require './new/route'
ShowRoute = require './show/route'
EditRoute = require './edit/route'

# # # # #

# PasswordRouter class definition
class PasswordRouter extends require '../base/router'

  routes:
    'passwords(/)':           'list'
    'passwords/new(/)':       'new'
    'passwords/:id(/)':       'show'
    'passwords/:id/edit(/)':  'edit'

  list: ->
    new ListRoute({ container: @container })

  new: ->
    new NewRoute({ container: @container })

  show: (id) ->
    new ShowRoute({ container: @container, id: id })

  edit: (id) ->
    new EditRoute({ container: @container, id: id })

# # # # #

module.exports = new PasswordRouter({ container: window.Layout.mainRegion })
