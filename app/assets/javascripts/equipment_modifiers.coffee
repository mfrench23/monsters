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
        ReactRailsUJS.mountComponents()
      )
  return

@getCocoonRowId = (element) ->
  return $(element).parents("[data-cocoon_row_id]:first").attr "data-cocoon_row_id" if element
  return -1

