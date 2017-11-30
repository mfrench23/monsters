class RpmRitualGridService
  def initialize
  end

  def grid(campaign_id)
    sql = grid_sql(campaign_id)
    ActiveRecord::Base.connection.exec_query(sql).inject({}) { |memo, hash| add_ritual memo, hash; memo }
  end

  private

  def add_ritual(hash, value_hash)
    path_name = value_hash["rpm_path_name"]
    effect_name = value_hash["rpm_effect_name"]
    potency_name = value_hash["rpm_potency_name"]
    ritual_id = value_hash["rpm_ritual_id"]
    ritual_name = value_hash["name"]
    ritual_description = value_hash["description"]
    typical_cost = value_hash["typical_cost"]
    add_structure_for_hash hash, path_name, effect_name, potency_name
    hash[path_name][effect_name][potency_name] << {:id => ritual_id, :name => ritual_name, :description => ritual_description, :typical_cost => typical_cost} if ritual_id.present?
  end

  def grid_sql(campaign_id)
    "select distinct eff.rpm_path_name, eff.rpm_effect_name, eff.rpm_potency_cost_factor,
      eff.rpm_potency_name, se.rpm_ritual_id, ri.name, ri.description, ri.typical_cost
    from
      (select
        pa.id as rpm_path_id, po.id as rpm_potency_id, ef.id as rpm_effect_id,
        pa.name as rpm_path_name, ef.name as rpm_effect_name, po.name as rpm_potency_name,
        po.cost_factor as rpm_potency_cost_factor
      from rpm_paths pa, rpm_effects ef, rpm_potencies po
      where pa.campaign_id = #{campaign_id}
        and ef.campaign_id = #{campaign_id}
        and po.campaign_id = #{campaign_id} ) eff 
      left outer join (select * from rpm_spell_effects where inherent = 1) se
        on eff.rpm_path_id = se.rpm_path_id
          and eff.rpm_effect_id = se.rpm_effect_id
          and eff.rpm_potency_id = se.rpm_potency_id
      left outer join rpm_rituals ri
        on se.rpm_ritual_id = ri.id
    order by eff.rpm_path_name, eff.rpm_effect_name, eff.rpm_potency_cost_factor, ri.name"
  end

  def add_structure_for_hash(hash, path_name, effect_name, potency_name)
    hash[path_name] = hash[path_name] || {}
    hash[path_name][effect_name] = hash[path_name][effect_name] || {}
    hash[path_name][effect_name][potency_name] = hash[path_name][effect_name][potency_name] || []
  end
end
