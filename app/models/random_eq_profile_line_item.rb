class RandomEqProfileLineItem < ActiveRecord::Base
  belongs_to :random_eq_profile
  belongs_to :equipment_modifier_supercategory

  validates :equipment_modifier_supercategory, presence: true
  validates :quantity, presence: true, numericality: { :greater_than => 0 }

  def to_s
    quantity.to_s + " " + equipment_modifier_supercategory.to_s.pluralize(quantity)
  end
end
