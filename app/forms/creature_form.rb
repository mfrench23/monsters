# Organizes the collection of parameters for a single instance of the Creature model
class CreatureForm < AbstractForm
  def initialize(params=nil)
    paramlist = CreatureForm.convert_freeform_skill_list(params)
    @params = monster_params(paramlist)
  end

  private

  def self.characteristics_param(params)
    params[:creature][:characteristic_monsters_attributes ]
  end

  def self.freeform_skill_param(params)
    params[:creature][:freeform_skill_list ]
  end

  def self.merge_converted_skill_list(params, skill_list)
    skill_list.list.each do |skill_attributes|
      CreatureForm.merge_skill_attributes_into_params(params, skill_attributes)
    end
    params[:creature][:freeform_skill_list ] = skill_list.text
    params
  end

  def self.merge_skill_attributes_into_params(params, skill_attributes)
    creature_params = params[:creature]
    creature_params[:skills_attributes] ||= {}
    creature_params[:skills_attributes].merge!({ creature_params[:skills_attributes].count.to_s => skill_attributes })
  end

  def self.convert_freeform_skill_list(params)
    return params unless params[:creature][:freeform_skill_list ].present?
    skill_list = FreeformSkillList.new( CreatureForm.freeform_skill_param(params), CreatureForm.characteristics_param(params) )
    CreatureForm.merge_converted_skill_list(params, skill_list)
  end

  def monster_params(params)
    params.require(:creature).permit( permitted_attributes )
  end

  def permitted_attributes
    [:name, :height, :weight, :gear,
      :description, :notes, :monster_class_id,
      :freeform_trait_list, :freeform_skill_list,
      :parts_value, :ancestry,
      characteristic_monsters_attributes: [:id, :characteristic_id, :score],
      illustrations_attributes: [:id, :image, :notes, :_destroy],
      campaign_contents_attributes: [:id, :campaign_id, :_destroy],
      monster_names_attributes: [:id, :name, :description, :_destroy],
      attacks_attributes: [:id, :name, :skill, :description, :_destroy],
      movement_rates_attributes: [:id, :move_type_id, :rate, :enhanced_rate, :_destroy],
      damage_resistances_attributes: [:id, :location_id, :dr, :notes, :_destroy],
      page_references_attributes: [:id, :book_id, :pages, :_destroy],
      parry_scores_attributes: [:id, :weapon, :parry, :_destroy],
      equipment_packages_attributes: EquipmentPackageForm.permitted_attributes,
      skills_attributes: [:id, :master_skill_id, :modifier, :specialization, :tech_level, :notes, :_destroy],
      traits_attributes: [:id, :master_trait_id, :level, :notes, :_destroy]
    ]
  end
end

# Tries to parse user-entered freeform text into skill descriptions
class FreeformSkillList
  attr_accessor :list
  attr_accessor :text

  def initialize(value, characteristics_hash)
    @list = []
    array_of_remainders = Logical::FreeformList.new(value).list.map { |item| add_to_list_returning_remaining_text(item, characteristics_hash) }
    @text = array_of_remainders.reject(&:nil?).join(";").strip
  end

  private

  def add_to_list_returning_remaining_text(text, characteristics_hash)
      skill_text = SkillText.new(text, characteristics_hash)
      @list << skill_text.skill if skill_text.skill.present?
      skill_text.remaining_text
  end

end

# Parses text representation of an instance of a GURPS Skill, as depicted on a
# particular character sheet (i.e., "Brawling @ DX+1", or "Acting 14")
class SkillText
  attr_accessor :remaining_text
  attr_accessor :skill

  def initialize(raw_text, characteristics_hash)
    @remaining_text = raw_text
    @working_text = raw_text.strip
    @characteristics_hash = characteristics_hash
    parse
    @master_skill = MasterSkill.find_by(name: @master_skill_name)
    populate_missing_modifier_value
    if has_required
      build_skill_hash
    end
  end

  private

  Regex_skill_name = /(?<skill_name>.*?)( \((?<specialization>[^)]*)\))?/
  Regex_actual_value = /(([^\w]+)(?<actual_value>[\d]+))?/
  Regex_notes = /(\((?<notes>[^)]*)\))?/
  Regex_attribute = /(DX|IQ|HT|Will|Per)/

  def parse
    pull_tech_level
    pull_characteristic_plus_modifier
    pull_skill_difficulty
    pull_skill_price
    pull_remainder
  end

  def characteristic_score(characteristic_id)
    ch_arr = @characteristics_hash.select do |key, arr|
      arr[:characteristic_id].to_s == characteristic_id.to_s
    end
    ch = ch_arr.values.first
    score = ch[:score] if ch.present?
    score
  end

  def pull_tech_level
    @working_text.gsub!(/\/TL[\d]+/) { |match| @tech_level = match[3..-1]; "" }
  end

  def pull_characteristic_plus_modifier
    @working_text.gsub!(/#{Regex_attribute}([+-]\d+)?/) do |match|
      @characteristic = $1
      mod_val = $2 || "0"
      @modifier_value = mod_val.tr("+"," ").strip
      ""
    end
  end

  def pull_skill_difficulty
    @working_text.gsub!(/ \((E|A|H|VH)\)/) { |match| "" }
  end

  def pull_skill_price
    @working_text.gsub!(/ \[\d+\]/) { |match| "" }
  end

  def pull_remainder
    if match = @working_text.match(/^#{Regex_skill_name}#{Regex_actual_value}([^\w]+)?#{Regex_notes}$/)
      @master_skill_name = match[:skill_name]
      @actual_value = match[:actual_value]
      @specialization = match[:specialization]
      @notes = match[:notes]
    end
  end

  def has_required
    (@master_skill.present?) &&
        (@characteristic.present?) &&
        (@modifier_value.present?) &&
        @master_skill.characteristic.to_s == @characteristic
  end

  def populate_missing_modifier_value
    return unless @master_skill.present?
    if @modifier_value.blank? && @actual_value.present?
      score = characteristic_score(@master_skill.characteristic.id)
      @modifier_value = @actual_value.to_i - score.to_i
      @characteristic = @master_skill.characteristic.to_s
    end
  end

  def build_skill_hash
    @skill = {:master_skill_id => @master_skill.id, :modifier => @modifier_value,
                        :tech_level => @tech_level,
                        :specialization => @specialization, :notes => @notes }
    @remaining_text = nil
  end
end
