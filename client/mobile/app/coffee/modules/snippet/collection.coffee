
# SnippetCollection class definition
# Defines a Backbone.Collection class used by SnippetService
class SnippetCollection extends Backbone.Collection
  url: '/snippets/'
  model: require './model'
  local: true  # Backbone.DualStorage configuration

# # # # #

module.exports = SnippetCollection
