module TypicalRitual
  extend ActiveSupport::Concern

  def base_cost
    all_elements.sum(&:cost)
  end

  def calc_typical_cost
    base_cost * overall_cost_factor
  end
end
