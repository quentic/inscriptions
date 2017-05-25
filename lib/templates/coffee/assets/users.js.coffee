# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  # gérer l'action sur la case à cocher profil "xxx"
  $("input").click ->
    $.post("/users/" + $(this).attr('data-user_id') + "/toggle_" + $(this).attr('class'))
