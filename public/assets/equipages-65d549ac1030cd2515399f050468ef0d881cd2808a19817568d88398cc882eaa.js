(function(){jQuery(function(){return $("#filtre").keyup(function(){var e;if(e=$(this).val(),e.length>3)return $.get("equipages/rechercher?terme="+e,function(e){return $("#liste_body").html(e)})})})}).call(this);