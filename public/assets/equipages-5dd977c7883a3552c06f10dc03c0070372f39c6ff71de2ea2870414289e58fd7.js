(function() {
  jQuery(function() {

    /*
      recherche les enregistrements correspondant au filtre de recherche
      quand le contenu du filtre change
     */
    return $("#filtre").keyup(function() {
      var terme;
      terme = $(this).val();

      /* make a GET call and replace the content */
      if (terme.length > 3) {
        return $.get("equipages/rechercher?terme=" + terme, function(data) {
          return $("#liste_body").html(data);
        });
      }
    });
  });

}).call(this);
