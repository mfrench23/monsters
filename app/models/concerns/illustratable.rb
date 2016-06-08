module Illustratable
  extend ActiveSupport::Concern

  included do
    has_many :illustrations, :as => :illustratable
    accepts_nested_attributes_for :illustrations, allow_destroy: true, :reject_if => lambda { |illustration| illustration['image'].nil? }
  end
end
