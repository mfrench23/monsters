module TraitsHelper
  def simpleTrait trait
    master = trait.master_trait

    feature = ""
    if master.is_feature
      feature = "Feature: "
    end

    level = ""
    if !trait.level.nil?
      level = trait.level.to_s
    end

    (feature + master.name + " " + level).strip
  end
end
