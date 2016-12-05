
class SidebarView extends Backbone.Marionette.LayoutView
  template: require './template'
  className: 'nav nav-pills nav-stacked'
  tagName: 'nav'

  events:
    'click a': 'onClicked'

  onClicked: ->
    Backbone.Radio.channel('sidebar').trigger('hide')

  modules: [
    { title:  'Devices',    icon: 'fa-bluetooth-b',   href: '#devices' }
    { title:  'Auto-Connect', icon: 'fa-refresh',     href: '#', divider: true }
    { title:  'Passwords',  icon: 'fa-key',           href: '#passwords' }
    { title:  'Snippets',   icon: 'fa-file-text-o',   href: '#snippets', divider: true }
    { title:  'Keyboard',   icon: 'fa-keyboard-o',    href: '#interface?type=keyboard' }
    { title:  'Mouse',      icon: 'fa-mouse-pointer', href: '#interface?type=mouse' }
    { title:  'Remote',     icon: 'fa-building',      href: '#interface?type=remote' }
    { title:  'Numpad',     icon: 'fa-calculator',    href: '#interface?type=numpad', divider: true }
    { title:  'Chrome',     icon: 'fa-chrome',        href: '#interface?type=chrome', divider: true  }
    # { title:  'Safari',     icon: 'fa-safari',        href: '#interface?type=safari' }
    # { title:  'Firefox',     icon: 'fa-firefox',        href: '#interface?type=firefox', divider: true }
    # { title:  'Gamepad',    icon: 'fa-gamepad',       href: '#interface?type=gamepad' }
    # { title:  'Thumbdrive', icon: 'fa-database',      href: '#interface/thumbdrive' }
    # { title:  'Mac OS',     icon: 'fa-apple',        href: '#interface?type=macos' }
    # { title:  'Windows',     icon: 'fa-windows',        href: '#interface?type=windows' }
    # { title:  'Linux',     icon: 'fa-linux',        href: '#interface?type=linux' }
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

module.exports = new SidebarComponent({ container: window.Layout.sidebar })
