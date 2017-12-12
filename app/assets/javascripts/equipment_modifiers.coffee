@loadInitialEquipmentPieceModifiers = (source) ->
  @reloadEquipmentPieceModifiers( source, $(source).data().equipment_piece_id, $(source).data().title );
  return

@reloadEquipmentPieceModifiers = (source_element, equipment_piece_id, title) ->
  if equipment_piece_id > 0
    target_div = $("div[name='ajax-modifiers-for-equipment-piece'][data-equipment_piece_id='" + equipment_piece_id + "']")
  else
    cocoonRowId = @getCocoonRowId(source_element)
    if cocoonRowId > 0
      target_div = $("*[data-cocoon_row_id=" + cocoonRowId + "]").find("div[name='ajax-modifiers-for-equipment-piece']")
    else
      return
    
  if target_div.length
    html_id = $(source_element).data().id
    $(target_div).empty()
    if equipment_piece_id < 0
      eq_p_id = 0
    else
      eq_p_id = equipment_piece_id
    
    equipment_type_id = $(target_div).parents("[data-cocoon_row_id]:first").find("select[data-id]:first").val()
    req = $.ajax({url: "/fetch_equipment_modifiers", type: "GET", data: { equipment_piece_id: eq_p_id, equipment_type_id: equipment_type_id, base_id: html_id, title: title }, cache: false })
      .done((html)->
        $(target_div).append(html)
        found = $(target_div).find("input:checkbox:first")
        if( found.length > 0 )
          disable_excluded_equipment_modifiers(found)
        ReactRailsUJS.mountComponents()
      )
  return

@getCocoonRowId = (element) ->
  return $(element).parents("[data-cocoon_row_id]:first").attr "data-cocoon_row_id" if element
  return -1

@disable_excluded_equipment_modifiers = (source) ->
  # find the container for all this piece's modifiers
  container = $(source).parents(".many_to_many_table")
  # enable all inputs
  container.find("input").prop("disabled", false)
  container.find("[data-displayed_field]").removeClass("disabled")
  # cycle through its child check boxes
  checkboxes = container.find("input:checked")
  selected_modifier_cells = checkboxes.parents(".many_to_many_cell").find("[name*=equipment_modifier_id]")
  selected_modifier_cells.each ->
    myId = this.value
    # if checked, find any modifier that has the matching id in its exclusion list
    exclusions = container.find("[name*=excluded_equipment_modifiers][value=" + myId + "]")
    # ... and disable it
    exclusions.parents(".many_to_many_cell").find("input").prop("disabled", true)
    exclusions.parents(".many_to_many_cell").find("[data-displayed_field]").addClass("disabled")
    return
  return