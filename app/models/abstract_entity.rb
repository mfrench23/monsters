# Encapsulates behavior common to all entities in the application
class AbstractEntity < ActiveRecord::Base
  self.abstract_class = true
end
