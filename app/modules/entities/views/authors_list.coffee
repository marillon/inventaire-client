ResultsList = require './results_list'

module.exports = class AuthorsList extends ResultsList
  getChildView: -> require './author_li'
  onShow: ->
    @addHeader('authors')
