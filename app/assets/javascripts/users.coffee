# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  setInterval (->
    $.ajax url: 'users/message_counter'
    return
  ), 600000
  return
