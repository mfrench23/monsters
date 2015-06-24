$(function() {
  $(".toggle-link").click(function(e) {
    var meta_id = e.currentTarget.name
    var children = $("." + meta_id);
    for(var i = 0; i < children.length; i++) {
      child = children[i];
      if(child.style.display == 'none')
        child.style.display = 'inline-block';
      else
        child.style.display = 'none';
    }
    e.preventDefault();
  });
});
