class MasterSkill < ActiveRecord::Base
  belongs_to :characteristic
  before_validation :nil_blank_attributes

  validates :name, :characteristic, presence: true

  private

  def nil_blank_attributes
    [:name, :notes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end
