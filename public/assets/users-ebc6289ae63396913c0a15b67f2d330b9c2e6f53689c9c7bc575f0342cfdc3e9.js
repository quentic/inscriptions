(function() {
  jQuery(function() {
    return $("input").click(function() {
      return $.post("/users/" + $(this).attr('data-user_id') + "/toggle_" + $(this).attr('class'));
    });
  });

}).call(this);
