module Dateable
  extend ActiveSupport::Concern

  included do
    scope :created_on, -> (date) { where("date(created_at) = ?", "#{date}")}
    scope :updated_on, -> (date) { where("date(updated_at) = ?", "#{date}")}
  end
end
