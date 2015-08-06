# A particular instance of an EquipmentType, like "Bob's
# broadsword with the gold wire on the hilt" or "the
# enchanted broadsword behind the door in Room #37".
class EquipmentPiece < AbstractEntity
  before_validation :calculate_dependant_values

  belongs_to :equipment_type
  belongs_to :owner, polymorphic: true

  has_many :equipment_modifiers, dependent: :destroy, :after_add => :nil_dependant_values, :after_remove => :nil_dependant_values
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true, :reject_if => lambda { |x| x['name'].blank? }

  has_one :equipment_category, :through => :equipment_type

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }

  delegate :name, to: :equipment_type, prefix: true
  delegate :name, to: :equipment_category, prefix: true

  scope :created_on, -> (date) { where("date(equipment_pieces.created_at) = ?", "#{date}")}
  scope :updated_on, -> (date) { where("date(equipment_pieces.updated_at) = ?", "#{date}")}

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

  def final_owner
    owner.final_owner unless owner.nil?
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

  def calc_depedent_value(method, starting_base = nil)
    starting_base ||= equipment_type.try(method)
    result = equipment_modifiers.reduce(starting_base) do |memo, mod|
      memo += mod.modifier_value_object(method).addition(starting_base)
    end
    return equipment_modifiers.reduce(result) do |memo, mod|
      memo *= mod.modifier_value_object(method).factor
    end
  end

  def calc_base_cost
    self.base_cost = calc_depedent_value(:base_cost)
  end

  def calc_base_weight
    self.base_weight = calc_depedent_value(:base_weight)
  end

  def calc_weight
    self.weight = calc_depedent_value(:weight, base_weight)
  end

  def calc_cost
    self.cost = calc_depedent_value(:cost, base_cost)
  end
end
