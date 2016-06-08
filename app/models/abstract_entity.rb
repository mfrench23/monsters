# Encapsulates behavior common to all entities in the application
class AbstractEntity < ActiveRecord::Base
  include Filterable

  self.abstract_class = true

  def deep_copy_reference(field, copy)
    send(field).each do |one_field|
      copy.send(field) << one_field.deep_copy
    end
  end
end
