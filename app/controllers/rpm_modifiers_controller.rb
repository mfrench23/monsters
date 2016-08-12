# Controller functionality specific to the RpmModifier model
class RpmModifiersController < ModelBasedController

  private

  def whitelisted_entity_params
    RpmModifierForm.new(params).params
  end
end
