class RandomEqProfileLineItem < ActiveRecord::Base
  belongs_to :random_eq_profile
  belongs_to :equipment_modifier_supercategory
  belongs_to :equipment_modifier_category

  validate :points_to_modifiers
  validates :quantity, presence: true, numericality: { :greater_than => 0 }

  def to_s
    quantity.to_s + " " + modifier_source.to_s.pluralize(quantity)
  end

  def modifier_source
    equipment_modifier_supercategory || equipment_modifier_category
  end

  private

  def points_to_modifiers
    pointer_count = (equipment_modifier_category ? 1 : 0) + (equipment_modifier_supercategory ? 1 : 0)
    if pointer_count != 1
      errors.add(:random_eq_profile_line_item, "must point to either a Modifier Category, or a Modifier Super-Category, but not both")
    end
  end
end
