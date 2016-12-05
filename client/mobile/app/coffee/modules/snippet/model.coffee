
# SnippetModel class definition
# Defines a Backbone.Model class used by the SnippetCollection & SnippetService
class SnippetModel extends Backbone.Model
  urlRoot: '/snippets/'

# # # # #

module.exports = SnippetModel
