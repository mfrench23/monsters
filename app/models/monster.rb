class Monster < ActiveRecord::Base
  has_many :page_references, dependent: :destroy
  accepts_nested_attributes_for :page_references, allow_destroy: true, reject_if: :all_blank
  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank
  has_many :traits, dependent: :destroy
  accepts_nested_attributes_for :traits, allow_destroy: true, reject_if: :all_blank
  has_many :attacks, dependent: :destroy
  accepts_nested_attributes_for :attacks, allow_destroy: true, reject_if: :all_blank
  has_many  :damage_resistances, dependent: :destroy
  accepts_nested_attributes_for :damage_resistances, allow_destroy: true, reject_if: :all_blank
  has_many  :movement_rates, dependent: :destroy
  accepts_nested_attributes_for :movement_rates, allow_destroy: true, reject_if: :all_blank
  has_many  :monster_names, dependent: :destroy
  accepts_nested_attributes_for :monster_names, allow_destroy: true,
      reject_if: lambda {|attributes| attributes['name'].blank? }
  
  def namelist
    retval = ""
    monster_names.each.with_index(1) do |nm, i| 
      if i < monster_names.count
	retval = retval + "; "
      end if
      retval = retval + nm.name
    end
    return retval
  end
end
