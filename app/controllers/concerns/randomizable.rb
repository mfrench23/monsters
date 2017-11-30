# Functionality common to all controllers of models that can be the starting
# point for the random generation of equipment.
module Randomizable
  extend ActiveSupport::Concern

  private

  def randomize_from(source)
    target = RandomEquipmentService.new.randomize(source)
    saved = target.try(:save)
    redirect_to target, notice: 'Randomly generated.' if saved
    redirect_back fallback_location: root_path, notice: 'Was not able to generate random equipment from ' + source.to_s unless saved
  end

end