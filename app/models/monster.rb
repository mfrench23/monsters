class Monster < AbstractEntity
  include Filterable

  before_validation :nil_blank_attributes

  actable touch: true # can be a "superclass" for MTI - gem active_record-acts_as - and gets updated_at along with its child
  has_ancestry # for determining which monsters are variants of others

  has_many :page_references, dependent: :destroy
  accepts_nested_attributes_for :page_references, allow_destroy: true, :reject_if => lambda { |x| x['book_id'].blank? && x['pages'].blank? }
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

  has_many :illustrations, :as => :illustratable
  accepts_nested_attributes_for :illustrations, allow_destroy: true, :reject_if => lambda { |x| x['image'].nil? }

  validates :name, :monster_class_id, presence: true

  scope :starting_with, -> (name) { where("upper(monsters.name) like ?", "#{name}%")}
  scope :created_on, -> (date) { where("date(monsters.created_at) = ?", "#{date}")}
  scope :updated_on, -> (date) { where("date(monsters.updated_at) = ?", "#{date}")}

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
    page_references.each { |pg| copy.page_references << pg.deep_copy }
    attacks.each { |a| copy.attacks << a.deep_copy }
    movement_rates.each { |mr| copy.movement_rates << mr.deep_copy }
    # monster names don't get copied
    characteristic_monsters.each { |cm| copy.characteristic_monsters << cm.deep_copy }
    illustrations.each { |illo| copy.illustrations << illo.deep_copy }
    copy.name = "Copy of #{name}"
    copy.parent = self
    copy
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

  def build_illustration
    Illustration.new
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
