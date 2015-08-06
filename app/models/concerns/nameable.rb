module Nameable
  extend ActiveSupport::Concern

  included do
    scope :order_by_name, -> { order(:name) }
    scope :starting_with, -> (name) { where("upper(name) like ?", "#{name}%")}
    validates :name, presence: true
    validates_uniqueness_of :name
    validates :name, length: { minimum: 2 }
  end

  def to_s
    name
  end
end
