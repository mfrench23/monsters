# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).bind 'cocoon:after-insert', (e, inserted_item) ->
  e.target.style.display = 'table-row'
  if $('#' + e.target.parentElement.id + ' ul > li:visible').length > 0
    e.target.firstElementChild.style.display = 'table-row'
  return

$(document).bind 'cocoon:after-remove', (e) ->
  if $('#' + e.target.parentElement.id + ' ul > li:visible').length == 1
    e.target.firstElementChild.style.display = 'none'
    e.target.style.display = 'none'
  return

@updateThumb = (source) ->
  files = source.files
  image = files[0]
  reader = new FileReader

  reader.onload = (file) ->
    img = new Image
    img.src = file.target.result
    img.setAttribute("height", "75");
    img.setAttribute("width", "75");
    targetEl = source.nextElementSibling
    # remove any existing image
    while(targetEl.firstChild)
      targetEl.removeChild targetEl.firstChild
    # add image being uploaded
    targetEl.appendChild(img)
    return

  reader.readAsDataURL image
  return
