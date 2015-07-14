# Encapsulates behavior common to all entities in the application
class AbstractEntity < ActiveRecord::Base
  self.abstract_class = true

  def deep_copy_reference(field, copy)
    send(field).each do |f|
      copy.send(field) << f.deep_copy
    end
  end
end
