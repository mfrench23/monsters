class Book < ActiveRecord::Base
  has_many :page_references, dependent: :destroy

  validates :name, presence: true
end
