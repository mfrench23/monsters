# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@toggle_control_group = (source_element) ->
  if source_element.selectedIndex > 0
    @toggle_off_control_group(source_element)
  else
    $(source_element).parents(".control-group").find('*[data-control_group_toggle]').prop('disabled', false)
  return

@toggle_off_control_group = (source_element) ->
  if source_element.selectedIndex > 0
    control_group_toggle = $(source_element).data().control_group_toggle
    $(source_element).parents(".control-group:first").find('*[data-control_group_toggle][data-control_group_toggle!="' + control_group_toggle + '"]').prop('disabled', true)
  return

$(window).load ->
  @toggle_off_control_group(fnd) for fnd in $( "*[data-control_group_toggle]" )
  return
    
