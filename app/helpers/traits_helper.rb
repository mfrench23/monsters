module TraitsHelper
  def simpleTrait trait 
    description = ""
    if trait.description.to_s.length > 0
      description = "(" + trait.description + ") "
    end 
    
    feature = ""
    if trait.is_feature 
      feature = "Feature: "
    end
    
    level = ""
    if !trait.level.nil? 
      level = trait.level.to_s
    end
    
    (feature + trait.name + " " + description + level).strip
  end
end
