(function() {
  jQuery(function() {
    var auto_fade_flash, fade_flash, show_ajax_message;
    $("select.dropdown").change(function() {
      console.log("le formulaire %s est soumis pour traitement", $(this).parent().attr("name"));
      $(this).parent().submit();
      return $(this).attr("selected", "selected");
    });
    $("#rechercher").css("display", "none");
    fade_flash = function() {
      return $("#flash_notice, #flash_alert, #flash_error, #error_explanation").click(function() {
        return $(this).fadeOut("slow");
      });
    };
    auto_fade_flash = function() {
      $("#flash_notice, #flash_alert, #flash_error").delay(3000).fadeOut("slow");
      return $("#error_explanation").delay(5000).fadeOut("slow");
    };
    auto_fade_flash();
    show_ajax_message = function(msg, type) {
      if ((type === "notice") || (type === "alert") || (type === "error")) {
        $("#flash_message").html('<section id="flash_' + type + '">' + msg + '</section>');
        return fade_flash();
      }
    };
    $(document).ajaxComplete(function(event, request) {
      var msg, type;
      msg = decodeURIComponent(escape(request.getResponseHeader('X-Message')));
      type = request.getResponseHeader('X-Message-Type');
      return show_ajax_message(msg, type);
    });
    $("tbody tr").click(function() {
      return $(this).toggleClass("on");
    });
    return $(".focus_defaut").first().focus().select();
  });

}).call(this);
