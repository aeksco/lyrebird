
class SnippetCollection extends Backbone.Collection
  url: '/snippets/'
  model: require './model'
  local: true  # Backbone.DualStorage configuration

# # # # #

module.exports = SnippetCollection
