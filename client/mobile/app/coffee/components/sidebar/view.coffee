
# SidebarView class definition
# The SidebarView renders the app's sidebar with
# the menuItems specified below
class SidebarView extends Marionette.LayoutView
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
    # { title:  'Gamepad',    icon: 'fa-gamepad',       href: '#interface?type=gamepad' }
  ]

  serializeData: ->
    return { modules: @modules }

# # # # #

module.exports = SidebarView
