
class SidebarView extends Backbone.Marionette.LayoutView
  template: require './template'
  className: 'nav nav-pills nav-stacked'
  tagName: 'nav'

  events:
    'click a': 'onClicked'

  onClicked: ->
    Backbone.Radio.channel('sidebar').trigger('hide')

  modules: [
    { title:  'Devices',    icon: 'fa-bluetooth-b',   href: '#devices', divider: true }
    # { title:  'Password',   icon: 'fa-key',           href: '#passwords' }
    { title:  'Keyboard',   icon: 'fa-keyboard-o',    href: '#interface/keyboard' }
    { title:  'Mouse',      icon: 'fa-mouse-pointer', href: '#interface/mouse' }
    { title:  'Gamepad',    icon: 'fa-gamepad',       href: '#interface/gamepad' }
    { title:  'Remote',     icon: 'fa-gamepad',       href: '#interface/remote' }
    # { title:  'Thumbdrive', icon: 'fa-database',      href: '#interface/thumbdrive' }
  ]

  serializeData: ->
    return { modules: @modules }

# # # # #

class SidebarComponent extends Backbone.Marionette.Service

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

module.exports = new SidebarComponent({ container: window.SidebarContainer })
