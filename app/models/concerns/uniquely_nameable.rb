module UniquelyNameable
  extend ActiveSupport::Concern
  include Nameable

  included do
    validates_uniqueness_of :name
  end
end
