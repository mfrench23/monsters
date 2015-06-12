# Encapsulates behavior common to all entities in the application
class AbstractEntity < ActiveRecord::Base
  self.abstract_class = true

  scope :created_on, -> (date) { where("date(created_at) = ?", "#{date}")}
  scope :updated_on, -> (date) { where("date(updated_at) = ?", "#{date}")}
end
