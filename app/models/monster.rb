class Monster < ActiveRecord::Base
  has_many :page_references
  has_many :skills
  has_many :traits
  has_many :attacks
  has_many  :damage_resistances
  has_many  :movement_rates
  has_many  :monster_names, dependent: :destroy
  accepts_nested_attributes_for :monster_names, allow_destroy: true,
      reject_if: lambda {|attributes| attributes['name'].blank? }
end
