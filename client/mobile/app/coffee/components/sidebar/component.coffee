SidebarView = require './view'

# SidebarComponent class definition
# The SidebarComponent manages the state and accessibility
# of the app's sidebar. The sidebar is used as the primary
# method of navigation inside the app
class SidebarComponent extends Marionette.Service

  radioEvents:
    'sidebar initialize': 'showView'
    'sidebar toggle':     'toggleSidebar'
    'sidebar hide':       'hideSidebar'

  showView: ->
    @view = new SidebarView({ modules: @modules })
    @options.container.show(@view)

  hideSidebar: ->
    return unless @view
    $('body').removeClass('sidebar-active')

  toggleSidebar: ->
    return unless @view
    $('body').toggleClass('sidebar-active')

# # # # #

module.exports = new SidebarComponent({ container: window.Layout.sidebarRegion })
