# A particular instance of an EquipmentType, like "Bob's
# broadsword with the gold wire on the hilt" or "the
# enchanted broadsword behind the door in Room #37".
class EquipmentPiece < AbstractEntity
  include Dateable

  before_save :calculate_values
  after_commit :update_owner

  belongs_to :equipment_type
  belongs_to :owner, polymorphic: true

  has_many :equipment_piece_modifiers, dependent: :destroy
  accepts_nested_attributes_for :equipment_piece_modifiers, allow_destroy: true
  has_many :equipment_modifiers, :through => :equipment_piece_modifiers

  has_one :equipment_category, :through => :equipment_type

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :total_cost_cents

  delegate :unit_of_measurement, to: :equipment_type
  delegate :name, to: :equipment_type, prefix: true
  delegate :name, to: :equipment_category, prefix: true

  validates :equipment_type, :quantity, presence: true

  def base_cost_cents
    self.base_cost = perform_modifications(:base_cost_modifier_value_object, equipment_type.try(:base_cost))
    read_attribute :base_cost_cents
  end

  def cost_cents
    self.cost = perform_modifications(:cost_modifier_value_object, base_cost)
    read_attribute :cost_cents
  end

  def total_cost_cents
    cost_cents * quantity
  end

  def base_weight
    self.base_weight = perform_modifications(:base_weight_modifier_value_object, equipment_type.try(:base_weight))
    read_attribute :base_weight
  end

  def weight
    self.weight = perform_modifications(:weight_modifier_value_object, base_weight)
    read_attribute :weight
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

  def update_owner
    return unless owner.present?
    owner.touch
    owner.save
  end

  def calculate_values
    base_weight
    weight
    base_cost
    cost
    return
  end

  def reference_list_attributes
    [:equipment_modifiers]
  end

  def perform_modifications(method, starting_base)
    result = equipment_modifiers.reduce(starting_base) do |memo, mod|
      memo += mod.try(method).addition(starting_base)
    end
    return equipment_modifiers.reduce(result) do |memo, mod|
      memo *= mod.try(method).factor
    end
  end
end
