# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Users
  @get_session_user_id = (callback) ->
    if Users.user_id
      return callback(Users.user_id)
    $.get(window.location.protocol + '//' + window.location.host + '/ajax/get_session_user_id', (data) ->
      Users.user_id = data
      callback(Users.user_id)
    )

window.Users = Users
