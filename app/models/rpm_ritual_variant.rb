class RpmRitualVariant < AbstractEntity
  include TypicalRitual

  belongs_to :rpm_ritual

  has_many :rpm_spell_effects, :through => :rpm_ritual

  has_many :rpm_ritual_variant_modifiers, :dependent => :destroy
  accepts_nested_attributes_for :rpm_ritual_variant_modifiers, allow_destroy: true

  after_save :calculate_cost

  delegate :overall_cost_factor, :to => :rpm_ritual

  validates_uniqueness_of :name, :scope => :rpm_ritual_id, :allow_nil => true, :allow_blank => true
  scope :order_by_name, -> { order(:name) }

  def self.from_ritual(ritual)
    variant = RpmRitualVariant.new(:rpm_ritual => ritual)
    # TODO Allow modification of values of inherent properties, so one can (for example) change the level of damage a spell does
    ritual.rpm_ritual_modifiers.where(:inherent => false).each do |m| 
      variant.rpm_ritual_variant_modifiers << RpmRitualVariantModifier.new(m.as_json.except("rpm_ritual_id", "inherent"))
    end
    variant
  end

  def all_elements
    inh = rpm_ritual.rpm_ritual_modifiers.to_ary.select{ |m| m.inherent == true }
    (rpm_spell_effects + inh + rpm_ritual_variant_modifiers)
  end

  def deep_copy
    copy = dup
    reference_list_attributes.each { |reference| deep_copy_reference(reference, copy) }
    copy
  end

  private

  def reference_list_attributes
    [:rpm_ritual_variant_modifiers]
  end

  def calculate_cost
    self.update_columns(:typical_cost => calc_typical_cost)
  end
end
