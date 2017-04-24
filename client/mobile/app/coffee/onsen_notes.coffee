
  # TODO - navigator
  # ons.notification.alert('Welcome to Onsen UI!')

  # console.log 'NEW ONSEN VIEW'

  # NOTE - views rendered into an element (i.e. standard region.show behavior)
  # Do not require any additional configuration for event bidings
  # setTimeout( =>
  #   view = new OnsenView({ el: '#splitContent' })
  #   view.render()
  # , 1000)


  # However, views rendered into the application with naviagor.pushPage() do require some additional configuration
  # Figure out which views will use this, and ensure that functionality will be consistent

  # navigator = document.getElementById('myNavigator')

  # setTimeout( =>

  #   navigator.pushPage('region', { pageHTML: view.$el.html() })
  #   view.setElement(view.elName)

  # , 1000)

  # navigator = document.getElementById("myNavigator")
  # navigator.pushPage('foo', { page: view.el })

  # setTimeout( =>

  #   # TODO - this should be abstracted into a region?
  #   # navigator.pushPage('foo', { pageHTML: view.el })
  #   # console.log view.isRendered()
  #   # console.log view.isAttached()
  #   # navigator.pushPage('foo', { pageHTML: view.$el.html() })

  # , 2000 )

# Page has loaded, document is ready
# $(document).on 'ready', =>
#   console.log 'ONSEN UI START'

# TODO - bluetooth service mock should return array of:
# {
# id:     "04:A3:16:0A:66:4A"
# known:  false
# name:   "Lyrebird"
# rssi:   -75
# }

# # # # #
