# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  ###
    recherche les enregistrements correspondant au filtre de recherche
    quand le contenu du filtre change
  ###
  $("#filtre").keyup ->
    terme = $(this).val()

    ### make a GET call and replace the content ###
    if terme.length > 3
      $.get("equipiers/rechercher?terme=" + terme, (data) ->
        $("#liste_body").html(data)
      )
    


