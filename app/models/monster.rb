class Monster < AbstractEntity
  include Filterable
  include PageReferenceable
  include Illustratable
  include CampaignContained

  before_validation :nil_blank_attributes

  actable touch: true # can be a "superclass" for MTI - gem active_record-acts_as - and gets updated_at along with its child
  has_ancestry :cache_depth => true # for determining which monsters are variants of others

  has_many :attacks, dependent: :destroy
  accepts_nested_attributes_for :attacks, allow_destroy: true, :reject_if => lambda { |x| x['name'].blank? && x['skill'].blank? && x['description'].blank? }
  has_many  :movement_rates, dependent: :destroy
  accepts_nested_attributes_for :movement_rates, allow_destroy: true, :reject_if => lambda { |x| x['rate'].blank? && x['move_type_id'].blank? }
  has_many  :monster_names, dependent: :destroy
  accepts_nested_attributes_for :monster_names, allow_destroy: true, :reject_if => lambda { |x| x['name'].blank? }
  has_many  :characteristic_monsters, dependent: :destroy
  accepts_nested_attributes_for :characteristic_monsters, allow_destroy: true, :reject_if => lambda { |x| x['characteristic_id'].blank? }

  has_many :characteristics, :through => :characteristic_monsters

  belongs_to :monster_class, counter_cache: true
  delegate :name, to: :monster_class, prefix: true

  validates :name, :monster_class_id, presence: true

  scope :starting_with, -> (name) { where("upper(monsters.name) like ?", "#{name}%")}
  scope :created_on, -> (date) { where("date(monsters.created_at) = ?", "#{date}")}
  scope :updated_on, -> (date) { where("date(monsters.updated_at) = ?", "#{date}")}

  scope :order_by_name, -> { order(:name) }

  def characteristic_monster(characteristic_name)
    characteristic_monsters.select{ |cm| cm.characteristic.name == characteristic_name.to_s}.try(:first) || CharacteristicMonster.get_instance(characteristic_name, self)
  end

  def characteristic_score(characteristic_name)
    characteristic_monster(characteristic_name).try { |x| x.characteristic.normalize(x.score) }
  end

  def combat_effectiveness_rating
    offensive_rating = characteristic_score "OR"
    protective_rating = characteristic_score "PR"
    offensive_rating.nil? || protective_rating.nil? ? nil : offensive_rating.to_i + protective_rating.to_i
  end

  def to_s
    name
  end

  def deep_copy
    copy = dup
    reference_list_attributes.each { |reference| deep_copy_reference(reference, copy) }
    transform_into_variant_of copy
  end

  def ancestor_accumulate_field(field)
    parent.expanded_field(field) unless is_root?
  end

  def expanded_field(field)
    ancestor_text = ancestor_accumulate_field(field)
    field_val = send(field)
    ancestor_text.to_s + (ancestor_text.blank? || field_val.blank? ? "" : "\n\n" ) + field_val.to_s
  end

  # required because cocoon uses reflect_on_association, which isn't fooled by actable
  def build_monster_name
    MonsterName.new
  end

  def build_movement_rate
    MovementRate.new
  end

  def build_attack
    Attack.new
  end

  private

  def transform_into_variant_of(copy)
    copy.description = copy.notes = nil # not inherited from parent
    copy.name = "Copy of #{name}" # aliases don't get copied, and name gets modified
    copy.parent = self
    copy
  end

  def reference_list_attributes
    [:page_references, :attacks, :movement_rates, :characteristic_monsters, :campaign_contents, :illustrations ]
  end

  def nil_blank_attributes
    [:description, :notes, :ancestry].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end
