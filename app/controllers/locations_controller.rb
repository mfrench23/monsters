class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    render locals: {
      locations: Location.order(view_context.sort_param(Location, params[:sort], params[:direction])).page( params[:page] )
    }
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    render locals: { location: set_location }
  end

  # GET /locations/new
  def new
    location = Location.new
    render locals: { location: location }
  end

  # GET /locations/1/edit
  def edit
    render locals: { location: set_location }
  end

  # POST /locations
  # POST /locations.json
  def create
    location = Location.new(location_params)

    respond_to do |format|
      if location.save
        format.html { redirect_to location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: location }
      else
        format.html { render :new, locals: {location: location} }
        format.json { render json: location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    location = set_location
    respond_to do |format|
      if location.update(location_params)
        format.html { redirect_to location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: location }
      else
        format.html { render :edit, locals: {location: location} }
        format.json { render json: location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    set_location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_location
      Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name)
    end
end
