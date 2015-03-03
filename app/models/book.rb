class Book < ActiveRecord::Base
  has_many :page_references
end
