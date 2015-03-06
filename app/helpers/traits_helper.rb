module TraitsHelper
  def simpleTrait trait 
    ((trait.is_feature ? "Feature: " : "" ) + trait.name + " " +
	(trait.description.length > 0 ? "(" + trait.description + ") " : "" ) +
	(!trait.level.nil? ? trait.level.to_s : "" )).strip
  end
end
