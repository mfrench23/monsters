# Generalized controller to handle one resource that is backed by an AbstractEntity
class ModelBasedController < ApplicationController
  include ResultSetReturning

  def create
    entity = controlled_model_class.new(whitelisted_entity_params)
    did_save = entity.save
    respond_to_data_change entity, did_save, Value_Set_Created
  end

  def destroy
    set_model_by_id.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: "#{controlled_model_class_name} was successfully destroyed." }
    end
  end

  def edit
    render locals: locals_hash(set_model_by_id)
  end

  def index
    render locals: index_locals_hash
  end

  def new
    render locals: locals_hash(controlled_model_class.new)
  end

  def show
    render locals: { controlled_model_symbol => set_model_by_id }
  end

  def update
    entity = set_model_by_id
    did_update = entity.update(whitelisted_entity_params)
    respond_to_data_change entity, did_update, Value_Set_Updated
  end

  private

  # string for message, status returned for success, page used for redirect in case of failure
  Value_Set_Created = ["created", :created, :new]
  Value_Set_Updated = ["updated", :ok, :edit]

  def respond_to_data_change(entity, save_ok, value_set)
    created_or_updated_string, show_status, error_page = value_set
    respond_to do |format|
      if save_ok && entity.errors.size() == 0
        format.html { redirect_to entity, notice: "#{controlled_model_class_name} was successfully #{created_or_updated_string}." }
        format.json { render :show, status: show_status, location: entity }
      else
        format.html { render error_page, locals: locals_hash(entity) }
        format.json { render json: entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def index_url
    url_for controller: controlled_model_class_name.tableize, action: :index
  end

  def index_locals_hash
    {
      controlled_model_plural_symbol => filtered_sorted_paginated_results,
      :starts_with_tags => (filtered_results.respond_to?(:first_letters) ? filtered_results.first_letters.count.keys.sort : nil),
      :campaign_name => name_of_filtering_campaign,
      :equipment_category_name => name_of_filtering_equipment_category,
      :equipment_modifier_category_name => name_of_filtering_modifier_category,
      :filter_params => filter_params
    }.merge(additional_index_locals)
  end

  def additional_index_locals
    {}
  end

  def locals_hash(entity)
    { controlled_model_symbol => entity }.merge(additional_form_locals)
  end

  # Hash of locals required by a specific controller's _form view.
  def additional_form_locals
    {}
  end

  def set_model_by_id
    controlled_model_class.find(params[:id])
  end
end
