class SwarmsController < ApplicationController
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @swarm = Swarm.new
    @swarm.movement_rates.build
    @swarm.attacks.build
  end

  def edit
  end

  def create
    form = SwarmForm.new(params)
    @swarm = Swarm.new(form.params)
    @swarm.save

    respond_to do |format|
      if @swarm.errors.size() == 0
	format.html { redirect_to @swarm, notice: 'Monster was successfully created.' }
	format.json { render :show, status: :created, location: @swarm }
      else
	format.html { render :new }
	format.json { render json: @swarm.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    form = SwarmForm.new(params)
    @swarm = Swarm.find(params[:id])
    @swarm.update(form.params)
    respond_to do |format|
      if @swarm.errors.size() == 0
	format.html { redirect_to @swarm, notice: 'Monster was successfully updated.' }
	format.json { render :show, status: :ok, location: @swarm }
      else
	format.html { render :edit }
	format.json { render json: @swarm.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @swarm.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_monster
    @swarm = Swarm.includes(monster: [:monster_names, :monster_class, characteristic_monsters: [:characteristic]] ).find(params[:id])
  end
end
