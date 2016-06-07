$(document).on('click', ".toggle-link", function(e) {
  var target_id = e.currentTarget.name
  $("[data-toggle_id=" + target_id + "]").toggle();
  e.preventDefault();
});
