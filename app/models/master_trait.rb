class MasterTrait < ActiveRecord::Base
  has_many :traits
  validates :name, presence: true

  def to_s
    (is_feature ? "Feature: " : "") + name + (notes.nil? ? "" : " (" + notes + ")")
  end
end
