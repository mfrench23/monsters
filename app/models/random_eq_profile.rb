class RandomEqProfile < ActiveRecord::Base
  include RandomlyOrderable

  belongs_to :equipment_type
  belongs_to :equipment_category

  has_many :random_eq_profile_line_items, dependent: :destroy
  accepts_nested_attributes_for :random_eq_profile_line_items, allow_destroy: true
end
