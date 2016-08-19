# Controller functionality specific to the RpmModifier model
class RpmModifiersController < ModelBasedController

  private

  def acceptable_filter_scopes
    [:starting_with, :in_campaign]
  end

  def whitelisted_entity_params
    RpmModifierForm.new(params).params
  end
end
