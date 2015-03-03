class MovementRatesController < ApplicationController
  before_action :set_movement_rate, only: [:show, :edit, :update, :destroy]

  # GET /movement_rates
  # GET /movement_rates.json
  def index
    @movement_rates = MovementRate.all
  end

  # GET /movement_rates/1
  # GET /movement_rates/1.json
  def show
  end

  # GET /movement_rates/new
  def new
    @movement_rate = MovementRate.new
  end

  # GET /movement_rates/1/edit
  def edit
  end

  # POST /movement_rates
  # POST /movement_rates.json
  def create
    @movement_rate = MovementRate.new(movement_rate_params)

    respond_to do |format|
      if @movement_rate.save
        format.html { redirect_to @movement_rate, notice: 'Movement rate was successfully created.' }
        format.json { render :show, status: :created, location: @movement_rate }
      else
        format.html { render :new }
        format.json { render json: @movement_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movement_rates/1
  # PATCH/PUT /movement_rates/1.json
  def update
    respond_to do |format|
      if @movement_rate.update(movement_rate_params)
        format.html { redirect_to @movement_rate, notice: 'Movement rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @movement_rate }
      else
        format.html { render :edit }
        format.json { render json: @movement_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movement_rates/1
  # DELETE /movement_rates/1.json
  def destroy
    @movement_rate.destroy
    respond_to do |format|
      format.html { redirect_to movement_rates_url, notice: 'Movement rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movement_rate
      @movement_rate = MovementRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movement_rate_params
      params.require(:movement_rate).permit(:monster_id, :terrain_type_id, :rate)
    end
end
