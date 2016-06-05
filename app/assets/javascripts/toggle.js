$(document).on('click', ".toggle-link", function(e) {
  var target_id = e.currentTarget.name
  var targets = $("[data-toggle_id=" + target_id + "]");
  for(var i = 0; i < targets.length; i++) {
    target = targets[i];
    if(target.style.display == 'none')
      target.style.display = 'inline-block';
    else
      target.style.display = 'none';
  }
  e.preventDefault();
});
