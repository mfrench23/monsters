class Monster < AbstractEntity
  include Filterable
  include PageReferenceable
  include Illustratable

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
  has_many :campaign_monsters, dependent: :destroy, inverse_of: :monster
  accepts_nested_attributes_for :campaign_monsters, allow_destroy: true, :reject_if => lambda { |x| x['campaign_id'].blank? }

  has_many :characteristics, :through => :characteristic_monsters

  belongs_to :monster_class, counter_cache: true
  delegate :name, to: :monster_class, prefix: true

  validates :name, :monster_class_id, presence: true

  scope :starting_with, -> (name) { where("upper(monsters.name) like ?", "#{name}%")}
  scope :created_on, -> (date) { where("date(monsters.created_at) = ?", "#{date}")}
  scope :updated_on, -> (date) { where("date(monsters.updated_at) = ?", "#{date}")}
  scope :in_campaign, -> (campaign_id) { where("0 < (select count(*) from campaign_monsters where campaign_monsters.monster_id = monsters.id and campaign_monsters.campaign_id = ?)", "#{campaign_id}") }

  scope :order_by_name, -> { order(:name) }

  def characteristic_monster(characteristic_name)
    characteristic_monsters.select{ |cm| cm.characteristic.name == characteristic_name.to_s}.try(:first) || generate_characteristic_monster(characteristic_name)
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
    deep_copy_reference(:page_references, copy)
    deep_copy_reference(:attacks, copy)
    deep_copy_reference(:movement_rates, copy)
    deep_copy_reference(:characteristic_monsters, copy)
    deep_copy_reference(:campaign_monsters, copy)
    deep_copy_reference(:illustrations, copy)
    copy.description = nil # not inherited from parent
    copy.notes = nil # not inherited from parent
    # aliases don't get copied, and name gets modified
    copy.name = "Copy of #{name}"
    copy.parent = self
    copy
  end

  def ancestor_description
    accumulated = ancestors.inject(nil) do |memo, ancestor|
      [memo, ancestor.description].join("\n\n")
    end
    accumulated
  end

  def expanded_description
    [ ancestor_description, description ].join("\n\n")
  end

  def ancestor_notes
    accumulated = ancestors.inject(nil) do |memo, ancestor|
      [memo, ancestor.notes].join("\n\n")
    end
    accumulated
  end

  def expanded_notes
    [ ancestor_notes, notes ].join("\n\n")
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

  def build_page_reference
    PageReference.new
  end

  def build_campaign_monster
    CampaignMonster.new
  end

  private

  def nil_blank_attributes
    [:description, :notes, :ancestry].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end

  def generate_characteristic_monster(characteristic_name)
    ch = CharacteristicList.characteristics_for(actable_type).select {|c| characteristic_name.to_s == c.name }.first
    CharacteristicMonster.new(:characteristic => ch, :monster => self, :score => ch.base_value) unless ch.nil?
  end
end
