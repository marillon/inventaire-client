RequestsList = require 'modules/users/views/requests_list'
NotificationsList = require 'modules/notifications/views/notifications_list'

module.exports = class AccountMenu extends Backbone.Marionette.LayoutView
  template: require './templates/account_menu'
  events:
    'click #edit, #pic': -> app.execute 'show:user:edit'
    'click #logout': -> app.execute 'persona:logout'

  serializeData: ->
    attrs =
      search:
        nameBase: 'search'
        field:
          placeholder: _.i18n 'Search for books or people'
        button:
          icon: 'search'
          classes: 'secondary'
    return _.extend attrs, @model.toJSON()

  initialize: ->
    # /!\ CommonEl custom Regions implies side effects
    # probably limited to the region management functionalities:
    # CommonEl regions insert their views AFTER the attached el
    @addRegion 'requests', app.Region.CommonEl.extend {el: '#before-requests'}
    @addRegion 'notifs', app.Region.CommonEl.extend {el: '#before-notifications'}

  onShow: ->
    app.execute 'foundation:reload'
    @showRequests()
    @showNotifications()

  showRequests: ->
    view = new RequestsList {collection: app.users.othersRequests}
    @requests.show view

  showNotifications: ->
    view = new NotificationsList {collection: app.user.notifications}
    @notifs.show view