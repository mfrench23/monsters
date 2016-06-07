# A GURPS equipment modifier, like "Cheap" or "Fine" or "Enchanted with..."
class EquipmentModifier < AbstractEntity
  belongs_to :equipment_modifier_category
  has_many :equipment_modifier_exclusions, dependent: :destroy
  accepts_nested_attributes_for :equipment_modifier_exclusions, allow_destroy: true
  has_many :excluded_by, :dependent => :destroy, :class_name => 'EquipmentModifierExclusion', :foreign_key => "excluded_id"

  has_many :equipment_piece_modifiers, dependent: :destroy
  has_many :equipment_pieces, :through => :equipment_piece_modifiers
  has_many :excluded_equipment_modifiers, :through => :equipment_modifier_exclusions, :source => :excluded

  delegate :name, to: :equipment_modifier_category, prefix: true

  after_commit :update_modified

  scope :order_by_name, -> { order(:name) }
  scope :order_by_category_and_name, -> { joins(:equipment_modifier_category).order('equipment_modifier_categories.name, equipment_modifiers.name') }

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :equipment_modifier_category_id
  validates :name, length: { minimum: 2 }

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
