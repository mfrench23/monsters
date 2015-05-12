# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).bind 'cocoon:after-insert', (e, inserted_item) ->
  if $('#' + e.target.parentElement.id + ' ul > li:visible').length > 0
    e.target.firstElementChild.style.display = 'table-row'
  return

$(document).bind 'cocoon:after-remove', (e) ->
  if $('#' + e.target.parentElement.id + ' ul > li:visible').length == 1
    e.target.firstElementChild.style.display = 'none'
  return

  