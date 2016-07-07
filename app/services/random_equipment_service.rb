class RandomEquipmentService
  def initialize(die_roll_service=nil)
    @die_roll_service = die_roll_service || DieRollService.new
  end

  def randomize(starting_point)
    return nil if starting_point.nil?
    randomize_from_entity(starting_point)
  end

  private

  def randomize_from_entity(starting_point)
    # extract a random_eq_profile from the starting_point
    profile = extract_profile(starting_point)
    randomize_from_profile(profile)
  end

  def randomize_from_profile(profile)
    return nil if profile.nil?
    # get a specific equipment_type from the profile
    equipment_type = get_equipment_type(profile)
    select_modifiers_and_quantity_based_on_profile_and_equipment_type(profile, equipment_type)
  end

  def select_modifiers_and_quantity_based_on_profile_and_equipment_type(profile, equipment_type)
    return nil if equipment_type.nil? || profile.nil?
    # get a random_eq_profile from the type, if it offers any
    detailed_profile = random_profile_from_collection(equipment_type.try(:random_eq_profiles))
    quantity = @die_roll_service.roll(combined_quantity(profile, detailed_profile), 1)
    modifier_list = get_modifier_list(equipment_type, profile, detailed_profile)
    generate_equipment_piece(equipment_type, modifier_list, quantity)
  end

  # quantity value from one profile times the quantity value from the other
  def combined_quantity(profile, detailed_profile)
    "(" + (profile.try(:quantity) || "1") + ")*(" + (detailed_profile.try(:quantity) || "1") + ")"
  end

  def generate_equipment_piece(equipment_type, modifier_list, quantity)
    piece = EquipmentPiece.new(:equipment_type => equipment_type, :quantity => quantity, :equipment_modifiers => modifier_list)
    package = EquipmentPackage.new
    package.equipment_pieces << piece
    package
  end

  def get_modifier_list(equipment_type, profile, detailed_profile)
    # combine the random_eq_profile instances to get a list of equipment_modifier_categories and counts, then select modifiers
    get_random_modifiers(equipment_type, [*profile.try(:random_eq_profile_line_items)] + [*detailed_profile.try(:random_eq_profile_line_items)])
  end

  def modifier_source(line_item)
    line_item.try(:equipment_modifier_supercategory) || line_item.try(:equipment_modifier_category)
  end

  def get_random_modifiers(equipment_type, array_of_line_items)
    list = []
    array_of_line_items.each do |line_item|
      source = modifier_source(line_item)
      excluded_ids = []
      (1..line_item.quantity).each do |counter|
        item = source.equipment_modifiers.where.not(:id => excluded_ids).merge( equipment_type.equipment_modifiers ).order_by_rand.first
        if item.present?
          list << item
          excluded_ids << item.id
          excluded_ids += item.excluded_equipment_modifiers.map(&:id)
        end
      end
    end
    list
  end

  def get_equipment_type(profile)
    return nil if profile.nil?
    profile.equipment_type || profile.equipment_category.equipment_types.order_by_rand.first
  end

  def extract_profile(entity)
    random_profile_from_collection(entity.try(:random_eq_profiles)) || self_if_profile(entity)
  end

  def random_profile_from_collection(collection)
    collection.try(:order_by_rand).try(:first)
  end

  def self_if_profile(entity)
    return entity if entity.respond_to?(:random_eq_profile_line_items) && entity.respond_to?(:equipment_type) && entity.respond_to?(:equipment_category)
    nil
  end
end
