# An entity that has a random_weight field, which can be used to put a result set into random order. By
# taking the first record returned, a random record of a result set can be returned.
module RandomlyOrderable
  extend ActiveSupport::Concern

  included do
    validates :random_weight, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 1 }

    # optional "seed" parameter can be used for repeatable results
    scope :order_by_rand, -> (opts = {}) { order("-log(rand(" + opts[:seed].to_s + "))*(1/random_weight)") }
  end
end