module ManyToManyCheckboxTableHelper
  def display_subheader(subheader)
    return content_tag(:span, subheader) unless subheader.blank?
    content_tag(:span, "(n/a) ", class: "footnote")
  end

  def display_other_values(base_id, key, val)
    capture do
      if val.respond_to?(:each_with_index)
        # must be an associated entity, so list the id for each one
        index = 0
        val.collect do |one_val|
          concat(hidden_field_tag("#{base_id}[#{key}][#{index}]", one_val.try(:id)))
          index += 1
        end
      else
        concat hidden_field_tag("#{base_id}[#{key}]", val)
      end
    end
  end
end
