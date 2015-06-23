$(function() {
  $(".toggle-link").click(function(e) {
    var el = e.currentTarget.parentNode.parentNode
    var children = el.childNodes;
    for(var i = 0; i < children.length; i++) {
      child = children[i];
      if(child.nodeName != "#text" ) {
        if(child.style.display == 'none')
          child.style.display = 'inline-block';
        else
          child.style.display = 'none';
      }
    }
    e.preventDefault();
  });
});
