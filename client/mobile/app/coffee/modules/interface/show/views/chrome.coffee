
# ChromeInterface class definition
# Defines an interface specifically for use with the Google Chrome
# web browser. Currently only difference from the KeyboardInterface
# is the input.type attribute defined in the template, though more additions
# will come in later builds.
class ChromeInterface extends require './keyboard'
  template: require './templates/chrome'

# # # # #

module.exports = ChromeInterface
