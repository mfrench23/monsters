class SwarmsController < ApplicationController
  def show
    render locals: { swarm: set_monster }
  end

  def new
    sw = Swarm.new
    sw.movement_rates.build
    sw.attacks.build
    render locals: { swarm: sw }
  end

  def variant
    swarm = Swarm.find(params[:id]).deep_copy
    render :new, locals: { swarm: swarm }
  end

  def edit
    render locals: { swarm: set_monster }
  end

  def create
    form = SwarmForm.new(params)
    swarm = Swarm.new(form.params)
    swarm.save

    respond_to do |format|
      if swarm.errors.size() == 0
	format.html { redirect_to swarm, notice: 'Monster was successfully created.' }
	format.json { render :show, status: :created, location: swarm }
      else
	format.html { render :new, locals: { swarm: swarm } }
	format.json { render json: swarm.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    form = SwarmForm.new(params)
    swarm = Swarm.find(params[:id])
    swarm.update(form.params)
    respond_to do |format|
      if swarm.errors.size() == 0
	format.html { redirect_to swarm, notice: 'Monster was successfully updated.' }
	format.json { render :show, status: :ok, location: swarm }
      else
	format.html { render :edit, locals: { swarm: swarm } }
	format.json { render json: swarm.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_monster.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_monster
    Swarm.find(params[:id])
  end
end
