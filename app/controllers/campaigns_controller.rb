class CampaignsController < ApplicationController
  # GET /campaigns
  # GET /campaigns.json
  def index
    render locals: {
      campaigns: Campaign.order(view_context.sort_param(Campaign, params[:sort], params[:direction])).page( params[:page] )
    }
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    render locals: { campaign: set_campaign }
  end

  # GET /campaigns/new
  def new
    render locals: { campaign: Campaign.new, monsters: all_monsters }
  end

  # GET /campaigns/1/edit
  def edit
    render locals: { campaign: set_campaign, monsters: all_monsters }
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    campaign = Campaign.new(campaign_params)

    respond_to do |format|
      if campaign.save
        format.html { redirect_to campaign, notice: 'Campaign was successfully created.' }
      else
        format.html { render :new, locals: {campaign: Campaign.new, monsters: all_monsters} }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    campaign = set_campaign
    respond_to do |format|
      if campaign.update(campaign_params)
        format.html { redirect_to campaign, notice: 'Campaign was successfully updated.' }
      else
        format.html { render :edit, locals: { campaign: set_campaign, monsters: all_monsters } }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    campaign = set_campaign
    campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
    end
  end

  private

  def all_monsters
    Monster.all
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    Campaign.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def campaign_params
    params.require(:campaign).permit(:name,
                                      campaign_monsters_attributes: [:id, :monster_id, :_destroy])
  end
end
