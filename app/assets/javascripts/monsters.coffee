# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# set insertion node for starting "add_fields" links
$(document).ready ->
  $('a.add_fields').data('association-insertion-position', 'append').data 'association-insertion-node', (link) ->
    @getCocoonInsertNode(link)
  return

$(document).bind 'cocoon:before-insert', (e, inserted_item) ->
  if inserted_item.data().cocoon_row_id <= 0
    new_id = new Date().getTime()
    inserted_item.attr "data-cocoon_row_id", new_id
  return

$(document).bind 'cocoon:after-insert', (e, inserted_item) ->
  # unhide, if inserted_item is the first object in the collection
  e.target.style.display = 'table-row'
  if $('#' + e.target.parentElement.id + ' ul > li:visible').length > 0
    e.target.firstElementChild.style.display = 'table-row'
  # post-insert processing for specific elements that might be inserted
  loadInitialEquipmentPieceModifiers(fnd) for fnd in $(inserted_item).find("div[name='ajax-modifiers-for-equipment-piece']")
  # set insertion node for any inserted "add_fields" links
  $(inserted_item).find('a.add_fields').data('association-insertion-position', 'append').data 'association-insertion-node', (link) ->
    @getCocoonInsertNode(link)
  return

$(document).bind 'cocoon:after-remove', (e) ->
  # if there are no remaining items to display, hide the header row
  if $('#' + e.target.parentElement.id + ' ul > li:visible').length == 1
    e.target.firstElementChild.style.display = 'none'
    e.target.style.display = 'none'
  return

@getCocoonInsertNode = (link) ->
  return link.prev()

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
