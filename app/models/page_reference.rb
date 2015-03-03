class PageReference < ActiveRecord::Base
  belongs_to :book
  belongs_to :monster
end
