class RandomEqProfile < ActiveRecord::Base
  belongs_to :equipment_type
  belongs_to :equipment_category

  has_many :random_eq_profile_line_items, dependent: :destroy
  accepts_nested_attributes_for :random_eq_profile_line_items, allow_destroy: true, :reject_if => lambda { |line_item| line_item[:quantity].blank? }

  validates :random_eq_profile_line_items, presence: true
end
