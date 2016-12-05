
# ConnectionObserver class definition
# Defines a class to observer a device's connection
# and RSSI. It also sends deviceFeedback alerts when a connected
# device's RSSI exceeds the threshold
class ConnectionObserver extends Marionette.Object

  # TODO - RSSI threshold should be a user setting
  threshold: -100

  initialize: (options) =>
    @device = options.device
    setTimeout(@checkPoll, 2000)

  checkPoll: =>
    return @startPolling() if @device.get('connected')
    @stopPolling()

  startPolling: =>
    return if @interval
    @interval = setInterval( @device.readRSSI, 500 )
    setInterval(@sendAlert, 500)

  # Send Alerts
  sendAlert: =>

    if @device.get('rssi') < @threshold

      # Leave - behind alerts
      # TODO - different sound?
      # TODO - haptic feedback intensity?
      plugins.deviceFeedback.haptic()
      plugins.deviceFeedback.acoustic()

  stopPolling: =>
    return unless @interval
    clearInterval(@interval)
    delete @interval

# # # # #

module.exports = ConnectionObserver
