require './hammer-time.min'
window.Promise = require 'bluebird'


# # # # #

# Cordova app & configuration
# CordovaApp = require './cordova_app'
# window.SmsWorker = SmsWorker = require './sms'

window.Container = require './config/layout'
window.LoadingView = require './views/loading'

# # # # #

HomeModule = require './modules/home/router'
ContactModule = require './modules/contact/router'
DeviceModule = require './modules/device/router'

# # # # #

# Cordova plugins
#   Contacts    https://github.com/apache/cordova-plugin-contacts
#   SMS         https://github.com/cordova-sms/cordova-sms-plugin
#   BLE         https://github.com/don/cordova-plugin-ble-central

# # # # # #

$(document).on 'ready', =>
  console.log 'Document Ready'
  Backbone.history.start()

  $('.navbar-brand').on 'click', ->
    for nav in $('.nav-item')
      $(nav).find('.nav-link').removeClass('active')

  $('.nav-item').on 'click', ->
    # console.log 'clicked'
    # console.log $(@)
    $(@).find('.nav-link').addClass('active')

    for nav in $(@).siblings('.nav-item')
      $(nav).find('.nav-link').removeClass('active')
