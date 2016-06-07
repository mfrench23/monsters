$(document).on('click', ".toggle-link", function(e) {
  var target_id = e.currentTarget.name
  $("[data-toggle_id=" + target_id + "]").toggle();
  e.preventDefault();
});

$(document).ready( function() {
  $('[data-select_all][data-target_toggle_id]').on('click', function(e) {
    target_toggle_id = $(e.currentTarget).data().target_toggle_id
    select_all = $(e.currentTarget).data().select_all
    $("[data-toggle_id=" + target_toggle_id + "]").find("input:checkbox").prop("checked", (select_all > 0));
    e.preventDefault();
  });
});