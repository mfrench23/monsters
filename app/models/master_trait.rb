class MasterTrait < ActiveRecord::Base
  has_many :traits
  validates :name, presence: true
  before_validation :nil_blank_attributes

  def to_s
    (is_feature ? "Feature: " : "") + name + (notes.nil? ? "" : " (" + notes + ")")
  end

  private

  def nil_blank_attributes
    [:name, :notes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end
