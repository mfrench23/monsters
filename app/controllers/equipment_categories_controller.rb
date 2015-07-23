class EquipmentCategoriesController < ApplicationController
  # GET /equipment_categories
  # GET /equipment_categories.json
  def index
    render locals: {
      equipment_categories: EquipmentCategory.order(view_context.sort_param(EquipmentCategory, params[:sort], params[:direction])).page( params[:page] )
    }
  end

  # GET /equipment_categories/1
  # GET /equipment_categories/1.json
  def show
    render locals: { equipment_category: set_equipment_category }
  end

  # GET /equipment_categories/new
  def new
    render locals: { equipment_category: EquipmentCategory.new }
  end

  # GET /equipment_categories/1/edit
  def edit
    render locals: { equipment_category: set_equipment_category }
  end

  # POST /equipment_categories
  # POST /equipment_categories.json
  def create
    equipment_category = EquipmentCategory.new(equipment_category_params)

    respond_to do |format|
      if equipment_category.save
        format.html { redirect_to equipment_category, notice: 'Equipment category was successfully created.' }
        format.json { render :show, status: :created, location: equipment_category }
      else
        format.html { render :new, locals: { equipment_category: equipment_category } }
        format.json { render json: equipment_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_categories/1
  # PATCH/PUT /equipment_categories/1.json
  def update
    equipment_category = set_equipment_category
    respond_to do |format|
      if equipment_category.update(equipment_category_params)
        format.html { redirect_to equipment_category, notice: 'Equipment category was successfully updated.' }
        format.json { render :show, status: :ok, location: equipment_category }
      else
        format.html { render :edit, locals: { equipment_category: equipment_category } }
        format.json { render json: equipment_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_categories/1
  # DELETE /equipment_categories/1.json
  def destroy
    set_equipment_category.destroy
    respond_to do |format|
      format.html { redirect_to equipment_categories_url, notice: 'Equipment category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_equipment_category
    EquipmentCategory.find(params[:id])
  end

  def equipment_category_params
    params.require(:equipment_category).permit(:name)
  end
end
