# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  # tout nouveau choix dans la liste déroulante déclenche la soumission du formulaire parent
  $("select.dropdown").change ->
    console.log("le formulaire %s est soumis pour traitement", $(this).parent().attr("name"))
    $(this).parent().submit()
    $(this).attr("selected", "selected")

  # et on masque le bouton de recherche
  $("#rechercher").css("display", "none")

  # FLASH NOTICE ANIMATION
  fade_flash = ->
    # Les messages d'erreur disparaissent quand on clique dessus
    $("#flash_notice, #flash_alert, #flash_error, #error_explanation").click ->
      $(this).fadeOut("slow")

  fade_flash()

  show_ajax_message = (msg, type) ->
    if (type == "notice") || (type == "alert") || (type == "error")
      $("#flash_message").html('<section id="flash_'+type+'">' +  msg + '</section>')
      fade_flash()

  $(document).ajaxComplete((event, request) ->
    msg = decodeURIComponent(escape(request.getResponseHeader('X-Message')))
    type = request.getResponseHeader('X-Message-Type')
    show_ajax_message(msg, type) #use whatever popup, notification or whatever plugin you want
  )

  # on marque les lignes cliquées pour faciliter le repérage visuel
  $("tbody tr").click ->
    $(this).toggleClass("on")

  # Donne le focus au champ qui a la classe "focus_defaut"
  # S'il y en a plusieurs, c'est le premier rencontré qui reçoit le focus
  $(".focus_defaut").first().focus().select()

  $.datepicker.setDefaults(
    changeMonth: true,
    changeYear: true,
    showMonthAfterYear: true,
    dateFormat: 'yy-mm-dd',
    minDate: "-80y"
  )
  $("input[type=date]").datepicker()

