class EquipmentTypesController < ApplicationController
  # GET /equipment_types
  # GET /equipment_types.json
  def index
    render locals: {
      equipment_types: filtered_sorted_paginated_results,
      starts_with_tags: first_characters_in_results,
      campaigns: all_campaigns_with_equipment_types.order_by_name,
      filter_params: filter_params(params),
      campaign_name: name_of_filtering_campaign
    }
  end

  # GET /equipment_types/1
  # GET /equipment_types/1.json
  def show
    render locals: { equipment_type: set_equipment_type }
  end

  # GET /equipment_types/new
  def new
    render locals: { equipment_type: EquipmentType.new, campaigns: all_campaigns }
  end

  # GET /equipment_types/1/edit
  def edit
    render locals: { equipment_type: set_equipment_type, campaigns: all_campaigns }
  end

  # POST /equipment_types
  # POST /equipment_types.json
  def create
    equipment_type = EquipmentType.new(equipment_type_params)

    respond_to do |format|
      if equipment_type.save
        format.html { redirect_to equipment_type, notice: 'Equipment type was successfully created.' }
        format.json { render :show, status: :created, location: equipment_type }
      else
        format.html { render :new, locals: { equipment_type: equipment_type, campaigns: all_campaigns } }
        format.json { render json: equipment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_types/1
  # PATCH/PUT /equipment_types/1.json
  def update
    equipment_type = set_equipment_type
    respond_to do |format|
      if equipment_type.update(equipment_type_params)
        format.html { redirect_to equipment_type, notice: 'Equipment type was successfully updated.' }
        format.json { render :show, status: :ok, location: equipment_type }
      else
        format.html { render :edit, locals: {equipment_type: equipment_type, campaigns: all_campaigns} }
        format.json { render json: equipment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_types/1
  # DELETE /equipment_types/1.json
  def destroy
    set_equipment_type.destroy
    respond_to do |format|
      format.html { redirect_to equipment_types_url, notice: 'Equipment type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def all_campaigns_with_equipment_types
    Campaign.has_contents(EquipmentType.to_s)
  end

  def first_characters_in_results
    filtered_results(params).group("substr(upper(name), 1,1)").count.keys.sort
  end

  def filtered_sorted_paginated_results
    filtered_sorted_results.page( params[:page] )
  end

  def filtered_sorted_results
    filtered_results(params).includes(:equipment_category).order(sort_params)
  end

  def sort_params
    view_context.sort_param(EquipmentType, params[:sort], params[:direction])
  end

  def set_equipment_type
    EquipmentType.find(params[:id])
  end

  def equipment_type_params
    params.require(:equipment_type).permit(permitted_attributes)
  end

  def permitted_attributes
    [:name, :base_weight, :base_cost, :equipment_category_id, :notes,
      campaign_contents_attributes: [:id, :campaign_id, :_destroy],
     ]
  end

  def filtered_results(params)
    EquipmentType.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:starting_with, :in_campaign)
  end
end
