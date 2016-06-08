module PageReferenceable
  extend ActiveSupport::Concern

  included do
    has_many :page_references, as: :referenceable, dependent: :destroy
    accepts_nested_attributes_for :page_references, allow_destroy: true, :reject_if => lambda { |ref| ref['book_id'].blank? && ref['pages'].blank? }
  end
end
