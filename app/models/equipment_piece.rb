# A particular instance of an EquipmentType, like "Bob's
# broadsword with the gold wire on the hilt" or "the
# enchanted broadsword behind the door in Room #37".
class EquipmentPiece < AbstractEntity
  include Dateable

  before_validation :calculate_dependant_values

  belongs_to :equipment_type
  belongs_to :owner, polymorphic: true

  has_many :equipment_modifiers, dependent: :destroy, :after_add => :nil_dependant_values, :after_remove => :nil_dependant_values
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true, :reject_if => lambda { |x| x['name'].blank? }

  has_one :equipment_category, :through => :equipment_type

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :total_cost_cents

  delegate :unit_of_measurement, to: :equipment_type
  delegate :name, to: :equipment_type, prefix: true
  delegate :name, to: :equipment_category, prefix: true

  validates :equipment_type, :quantity, presence: true

  def base_cost_cents
    calculate_dependant_value(:base_cost_cents, :calc_base_cost)
  end

  def cost_cents
    calculate_dependant_value(:cost_cents, :calc_cost)
  end

  def total_cost_cents
    cost_cents * quantity
  end

  def base_weight
    calculate_dependant_value(:base_weight, :calc_base_weight)
  end

  def weight
    calculate_dependant_value(:weight, :calc_weight)
  end

  def total_weight
    weight * quantity
  end

  def final_owner
    owner.try(:final_owner)
  end

  def deep_copy
    copy = dup
    reference_list_attributes.each { |reference| deep_copy_reference(reference, copy) }
    copy
  end

  private

  def reference_list_attributes
    [:equipment_modifiers]
  end

  def nil_dependant_values(optional_modifier)
    self.base_cost_cents = self.base_weight = self.cost_cents = self.weight = nil
  end

  def calculate_dependant_values
    calc_base_cost
    calc_base_weight
    calc_weight
    calc_cost
  end

  def perform_modifications(method, starting_base)
    result = equipment_modifiers.reduce(starting_base) do |memo, mod|
      memo += mod.try(method).addition(starting_base)
    end
    return equipment_modifiers.reduce(result) do |memo, mod|
      memo *= mod.try(method).factor
    end
  end

  def calc_base_cost
    self.base_cost = perform_modifications(:base_cost_modifier_value_object, equipment_type.try(:base_cost))
  end

  def calc_base_weight
    self.base_weight = perform_modifications(:base_weight_modifier_value_object, equipment_type.try(:base_weight))
  end

  def calc_weight
    self.weight = perform_modifications(:weight_modifier_value_object, base_weight)
  end

  def calc_cost
    self.cost = perform_modifications(:cost_modifier_value_object, base_cost)
  end
end
