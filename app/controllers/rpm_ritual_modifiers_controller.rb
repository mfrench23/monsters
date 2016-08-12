class RpmRitualModifiersController < ApplicationController
  def subtypes
    rpm_modifier = RpmModifier.find(params[:id])
    respond_to do |format|
      format.json { render json: rpm_modifier.rpm_modifier_subtypes.order_by_name }
    end
  end

  def levels
    rpm_modifier = RpmModifier.find(params[:id])
    respond_to do |format|
      format.json { render json: rpm_modifier.rpm_modifier_levels.order_by_cost }
    end
  end
end
