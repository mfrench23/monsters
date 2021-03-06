# A thing with a name
module Nameable
  extend ActiveSupport::Concern

  included do
    scope :order_by_name, -> { order(:name) }
    scope :first_letters, -> { select(:name).group("substr(upper(name), 1, 1)") }
    scope :starting_with, -> (name) { where("upper(name) like ?", "#{name}%")}

    validates :name, presence: true
    validates :name, length: { minimum: 2 }
  end

  def to_s
    name
  end
end
