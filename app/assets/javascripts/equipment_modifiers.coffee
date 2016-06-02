@loadInitialEquipmentPieceModifiers = (source) ->
  @reloadEquipmentPieceModifiers( source, $(source).data().equipment_piece_id, $(source).data().equipment_type_id, $(source).data().title );
  return

@reloadEquipmentPieceModifiers = (source_element, equipment_piece_id, equipment_type_id, title) ->
  target_div = $("div[name='ajax-modifiers-for-equipment-piece'][data-equipment_piece_id='" + equipment_piece_id + "']")
  if target_div.length
    html_id = $(source_element).data().id
    $(target_div).empty()
    req = $.ajax({url: "/fetch_equipment_modifiers", type: "GET", data: { equipment_piece_id: equipment_piece_id, equipment_type_id: equipment_type_id, base_id: html_id, title: title }, cache: false })
      .done((html)->
        $(target_div).append(html)
      )
  return
