class RpmRitualModifiersController < ApplicationController
  def show
    rpm_modifier = RpmModifier.find(params[:id])
    respond_to do |format|
      format.json { render json: rpm_modifier.rpm_modifier_levels }
    end
  end
end
