module SortableHelper
  def sortable(column, klass, params, title = nil)
    title ||= column.titleize
    curr_col = sort_column(klass, params[:sort])
    sd = sort_direction(params[:direction])
    direction = (column == curr_col && sd == "asc") ? "desc" : "asc"
    link_to title, params.merge({:sort => column, :direction => direction}), {:class => css_class(column, curr_col, sd)}
  end

  def sort_param(klass, param_sort, param_direction)
    col = sort_column(klass, param_sort)
    dir = sort_direction(param_direction)
    col.split(",").map { |field| "#{field} #{dir}" }.join(",")
  end

  def is_acceptable_sort_column(klass, column)
    return false if column.blank?
    return is_acceptable_sort_list(klass, column) || is_acceptable_reference(klass, column) || klass.column_names.include?(column)
  end

  private

  def is_acceptable_reference(klass, column)
    if m = column.match(/^(.*?)\.(.*)$/)
      return is_reference_acceptable_sort_column(klass, m[1], m[2])
    end
  end

  # Checks a comma-delimited list to see if each item is an acceptable sort field
  def is_acceptable_sort_list(klass, column)
    if m = column.match(/^(.*?), *(.*)$/)
      return is_acceptable_sort_column(klass, m[1]) && is_acceptable_sort_column(klass, m[2])
    end
  end

  def is_reference_acceptable_sort_column(klass, table, field)
    return is_acceptable_sort_column(klass, field) if klass.table_name == table
    reflection = klass.reflect_on_association(table.singularize)
    return is_acceptable_sort_column(reflection.klass, field) if( reflection )
    false
  end

  def css_class(column, curr_col, direction)
    (column == curr_col) ? "current #{direction} quiet" : "quiet"
  end

  def get_default(klass)
    column_name_or_nil(klass, "name") || column_name_or_nil(klass, "description") || column_name_or_nil(klass, "id")
  end

  def column_name_or_nil(klass, column_name)
    if klass.column_names.include?(column_name)
      table_name = klass.table_name
      table_name.to_s + "." + column_name.to_s
    else
      nil
    end
  end

  def sort_column(klass, param_sort)
    is_acceptable_sort_column(klass, param_sort) ? param_sort : get_default(klass)
  end

  def sort_direction(param_direction)
    %w[asc desc].include?(param_direction) ? param_direction : "asc"
  end
end
