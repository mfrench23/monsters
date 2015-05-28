class Monster < ActiveRecord::Base
  include Filterable

  actable # can be a "superclass" for MTI - gem active_record-acts_as

  has_many :page_references, dependent: :destroy
  accepts_nested_attributes_for :page_references, allow_destroy: true, reject_if: :all_blank
  has_many :attacks, dependent: :destroy
  accepts_nested_attributes_for :attacks, allow_destroy: true, reject_if: :all_blank
  has_many  :movement_rates, dependent: :destroy
  accepts_nested_attributes_for :movement_rates, allow_destroy: true, reject_if: :all_blank
  has_many  :monster_names, dependent: :destroy
  accepts_nested_attributes_for :monster_names, allow_destroy: true, reject_if: :all_blank
  has_many  :characteristic_monsters, dependent: :destroy
  accepts_nested_attributes_for :characteristic_monsters, allow_destroy: true, reject_if: :all_blank

  has_many :characteristics, :through => :characteristic_monsters

  belongs_to :monster_class
  delegate :name, to: :monster_class, prefix: true

  has_many :illustrations, :as => :illustratable
  accepts_nested_attributes_for :illustrations, allow_destroy: true, :reject_if => lambda { |x| x['image'].nil? }

  validates :name, :monster_class_id, presence: true

  scope :starts_with, -> (name) { where("upper(name) like ?", "#{name}%")}

  def initialize(params={})
    super(params)
    attacks.build unless attacks.try(:any?)
    movement_rates.build unless movement_rates.try(:any?)
  end

  def characteristic_score(characteristic_name)
    self.characteristic_monsters.select{ |cm| cm.characteristic.name == characteristic_name.to_s}.first.try { |x| x.characteristic.normalize(x.score) }
  end

  def combat_effectiveness_rating
    offensive_rating = characteristic_score "OR"
    protective_rating = characteristic_score "PR"
    offensive_rating.nil? || protective_rating.nil? ? nil : offensive_rating.to_i + protective_rating.to_i
  end

  # All the monster's aliases, in a semicolon-delimited list.
  def names_to_s
    monster_names.sort.collect { |x| x.name }.join('; ')
  end

  def to_s
    name
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
end
