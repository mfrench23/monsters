// toggle display of elements with the source element's name in their data-toggle_id attribute
$(document).on('click', ".toggle-link", function(e) {
  var target_id = e.currentTarget.name
  $("[data-toggle_id=" + target_id + "]").toggle();
  e.preventDefault();
});

// select all/none of the checkboxes with a data-toggle_id attribute matching the clicked element's target-toggle_id attribute
$(document).ready( function() {
  $('[data-select_all][data-target_toggle_id]').on('click', function(e) {
    target_toggle_id = $(e.currentTarget).data().target_toggle_id
    select_all = $(e.currentTarget).data().select_all
    $("[data-toggle_id=" + target_toggle_id + "]").find("input:checkbox").prop("checked", (select_all > 0));
    e.preventDefault();
  });
});