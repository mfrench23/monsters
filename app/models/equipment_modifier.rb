# A GURPS equipment modifier, like "Cheap" or "Fine" or "Enchanted with..."
class EquipmentModifier < AbstractEntity
  belongs_to :equipment_modifier_category
  has_many :equipment_piece_modifiers, dependent: :destroy
  has_many :equipment_pieces, :through => :equipment_piece_modifiers

  after_commit :update_modified

  def base_cost_modifier_value_object
    EquipmentModifier::ModifierValueObject.get_instance(base_cost_mod, true)
  end

  def cost_modifier_value_object
    EquipmentModifier::ModifierValueObject.get_instance(cost_mod, true)
  end

  def base_weight_modifier_value_object
    EquipmentModifier::ModifierValueObject.get_instance(base_weight_mod)
  end

  def weight_modifier_value_object
    EquipmentModifier::ModifierValueObject.get_instance(weight_mod)
  end

  def to_s
    "#{name} (" + modifiers_to_s + notes_to_s + ")"
  end

  def deep_copy
    dup
  end

  private

  def update_modified
    equipment_pieces.each do |equipment_piece|
      equipment_piece.touch
      equipment_piece.save
    end
  end

  def notes_to_s
    return "; " + notes if notes.present?
    ""
  end

  def modifiers_to_s
    [base_cost_to_s, base_weight_to_s, cost_modifier_value_object.to_s, weight_to_s].reject{ |member| member.blank? }.join(", ")
  end

  def weight_to_s
     weight_modifier_value_object.to_s + " wt" if weight_mod.present?
  end

  def base_weight_to_s
    "base weight " + base_weight_modifier_value_object.to_s if base_weight_mod.present?
  end

  def base_cost_to_s
    "base cost " + base_cost_modifier_value_object.to_s if base_cost_mod.present?
  end
end
