module Illustratable
  extend ActiveSupport::Concern

  included do
    has_many :illustrations, :as => :illustratable
    accepts_nested_attributes_for :illustrations, allow_destroy: true, :reject_if => lambda { |x| x['image'].nil? }
  end

  def build_illustration
    Illustration.new
  end
end
