@updateDynamicSelect = (parent_select) ->
  id = parent_select.options[parent_select.selectedIndex].value
  $(parent_select).parents(".control-group:first").find("select[data-dynamic_select_child]").each (i) ->
    child = $(this)
    url = child.data('dynamic_select_data_source') + "/" + id + ".json"
    id_field = child.data('dynamic_select_key_method') || "id"
    name_field = child.data('dynamic_select_value_method') || "name"
    original_id = child.data('dynamic_select_original_selection')
    child.empty()
    $.ajax({url: url, type: "GET", cache: false, dataType: "json" }) 
      .done((data) ->
        $.each data, (i, object) ->
          opts = $('<option>').attr('value', object[id_field]).text(object[name_field])
          if object[id_field] == original_id
            opts = opts.attr('selected', 'selected')
          child.append opts
          return
        child.change()
      )
    return
  return
