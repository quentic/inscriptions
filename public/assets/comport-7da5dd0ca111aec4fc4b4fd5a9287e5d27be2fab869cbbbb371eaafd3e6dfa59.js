(function(){jQuery(function(){var e,t,r;return $("select.dropdown").change(function(){return console.log("le formulaire %s est soumis pour traitement",$(this).parent().attr("name")),$(this).parent().submit(),$(this).attr("selected","selected")}),$("#rechercher").css("display","none"),t=function(){return $("#flash_notice, #flash_alert, #flash_error, #error_explanation").click(function(){return $(this).fadeOut("slow")})},e=function(){return $("#flash_notice, #flash_alert, #flash_error, #error_explanation").delay(3e3).fadeOut("slow")},e(),r=function(e,r){if("notice"===r||"alert"===r||"error"===r)return $("#flash_message").html('<section id="flash_'+r+'">'+e+"</section>"),t()},$(document).ajaxComplete(function(e,t){var n,s;return n=decodeURIComponent(escape(t.getResponseHeader("X-Message"))),s=t.getResponseHeader("X-Message-Type"),r(n,s)}),$("tbody tr").click(function(){return $(this).toggleClass("on")}),$(".focus_defaut").first().focus().select()})}).call(this);