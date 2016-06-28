# A single monster entry, in the "Monster Manual" sense, which may refer to
# a single unique individual (the Tarrasque), a "species" of creatures (goblins,
# unicorns), or a group of creatures acting in concert (a flock of birds)
class Monster < AbstractEntity
  include CampaignContained
  include Dateable
  include Illustratable
  include UniquelyNameable
  include PageReferenceable
  include NilBlankable

  after_initialize :populate_new_monster
  before_validation :nil_blank_attributes

  actable touch: true # can be a "superclass" for MTI - gem active_record-acts_as - and gets updated_at along with its child
  has_ancestry :cache_depth => true # for determining which monsters are variants of others

  has_many :attacks, dependent: :destroy
  accepts_nested_attributes_for :attacks, allow_destroy: true, :reject_if => lambda { |attack| attack['name'].blank? && attack['skill'].blank? && attack['description'].blank? }
  has_many  :movement_rates, dependent: :destroy
  accepts_nested_attributes_for :movement_rates, allow_destroy: true, :reject_if => lambda { |move| move['rate'].blank? && move['move_type_id'].blank? }
  has_many  :monster_names, dependent: :destroy
  accepts_nested_attributes_for :monster_names, allow_destroy: true, :reject_if => lambda { |name| name['name'].blank? }
  has_many  :characteristic_monsters, dependent: :destroy
  accepts_nested_attributes_for :characteristic_monsters, allow_destroy: true, :reject_if => lambda { |char| char['characteristic_id'].blank? }

  has_many :characteristics, :through => :characteristic_monsters

  belongs_to :monster_class, counter_cache: true
  delegate :name, to: :monster_class, prefix: true

  validates :monster_class_id, presence: true

  def characteristic_monster(characteristic_name)
    characteristic_monsters.select{ |cm| cm.characteristic.name == characteristic_name.to_s}.try(:first) || CharacteristicMonster.get_instance(characteristic_name, self)
  end

  def characteristic_score(characteristic_name)
    characteristic_monster(characteristic_name).try { |characteristic_monster| characteristic_monster.characteristic.normalize(characteristic_monster.score) }
  end

  def combat_effectiveness_rating
    offensive_rating = characteristic_score "OR"
    protective_rating = characteristic_score "PR"
    offensive_rating.to_i + protective_rating.to_i if (offensive_rating.present? && protective_rating.present?)
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

  private

  def transform_into_variant_of(copy)
    copy.description = copy.notes = nil # not inherited from parent
    copy.name = "Copy of #{name}" # aliases don't get copied, and name gets modified
    copy.parent = self
    copy
  end

  def reference_list_attributes
    [:page_references, :attacks, :movement_rates, :characteristic_monsters, :illustrations ]
  end

  def blankable_attributes
    [:description, :notes, :ancestry]
  end

  def populate_new_monster
    if self.new_record?
      movement_rates.build if movement_rates.empty?
      attacks.build if attacks.empty?
    end
  end
end
