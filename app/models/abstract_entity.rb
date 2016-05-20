# Encapsulates behavior common to all entities in the application
class AbstractEntity < ActiveRecord::Base
  include Filterable

  self.abstract_class = true

  def deep_copy_reference(field, copy)
    send(field).each do |f|
      copy.send(field) << f.deep_copy
    end
  end

  private

  # If the given attribute is nil, try to populate it using
  # method_to_populate; either way, return the value of the
  # attribute (either non-nil or populated).
  def calculate_dependant_value(attribute_name, method_to_populate)
    if read_attribute(attribute_name).nil?
      self.send(method_to_populate)
    end
    read_attribute(attribute_name)
  end
end
