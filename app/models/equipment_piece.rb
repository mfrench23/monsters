# A particular instance of an EquipmentType, like "Bob's
# broadsword with the gold wire on the hilt" or "the
# enchanted broadsword behind the door in Room #37".
class EquipmentPiece < ActiveRecord::Base
  include Filterable

  before_validation :calculate_dependant_values

  belongs_to :equipment_type

  has_many :equipment_modifiers, dependent: :destroy, :after_add => :nil_dependant_values, :after_remove => :nil_dependant_values
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true, :reject_if => lambda { |x| x['name'].blank? }

  has_one :equipment_category, :through => :equipment_type

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }

  delegate :name, to: :equipment_type, prefix: true
  delegate :name, to: :equipment_category, prefix: true

  scope :created_on, -> (date) { where("date(equipment_pieces.created_at) = ?", "#{date}")}
  scope :updated_on, -> (date) { where("date(equipment_pieces.updated_at) = ?", "#{date}")}
  scope :order_by_name, -> { order(:name) }

  validates :equipment_type, presence: true

  def base_cost_cents
    calculate_dependant_value(:base_cost_cents, :calc_base_cost)
  end

  def cost_cents
    calculate_dependant_value(:cost_cents, :calc_cost)
  end

  def base_weight
    calculate_dependant_value(:base_weight, :calc_base_weight)
  end

  def weight
    calculate_dependant_value(:weight, :calc_weight)
  end

  private

  def calculate_dependant_value(attribute_name, method_to_populate)
    if read_attribute(attribute_name).nil?
      self.send(method_to_populate)
    end
    read_attribute(attribute_name)
  end

  def nil_dependant_values(optional_modifier)
    self.base_cost_cents = nil
    self.base_weight = nil
    self.cost_cents = nil
    self.weight = nil
  end

  def calculate_dependant_values
    calc_base_cost
    calc_base_weight
    calc_weight
    calc_cost
  end

  def calc_base_cost
    starting_base_cost = equipment_type.try(:base_cost)
    result = equipment_modifiers.reduce(starting_base_cost) do |memo, mod|
      memo += mod.modifier_value_object(:base_cost).addition(starting_base_cost)
    end
    self.base_cost = equipment_modifiers.reduce(result) do |memo, mod|
      memo *= mod.modifier_value_object(:base_cost).factor
    end
  end

  def calc_base_weight
    starting_base_weight = equipment_type.try(:base_weight)
    result = equipment_modifiers.reduce(starting_base_weight) do |memo, mod|
      memo += mod.modifier_value_object(:base_weight).addition(starting_base_weight)
    end
    self.base_weight = equipment_modifiers.reduce(result) do |memo, mod|
      memo *= mod.modifier_value_object(:base_weight).factor
    end
  end

  def calc_weight
    result = equipment_modifiers.reduce(base_weight) do |memo, mod|
      memo += mod.modifier_value_object(:weight).addition(base_weight)
    end
    self.weight = equipment_modifiers.reduce(result) do |memo, mod|
      memo *= mod.modifier_value_object(:weight).factor
    end
  end

  def calc_cost
    result = equipment_modifiers.reduce(base_cost) do |memo, mod|
      memo += mod.modifier_value_object(:cost).addition(base_cost)
    end
    self.cost = equipment_modifiers.reduce(result) do |memo, mod|
      memo *= mod.modifier_value_object(:cost).factor
    end
  end
end
