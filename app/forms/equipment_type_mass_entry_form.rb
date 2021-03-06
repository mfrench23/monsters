# Organizes the collection of parameters for the mass entry and creation
# of multiple instances of EquipmentType model
class EquipmentTypeMassEntryForm < AbstractEquipmentTypeForm
  attr_accessor :equipment_types, :error_messages

  def initialize(params=nil, campaign_id)
    @params = whitelisted_params(params)
    @equipment_types = []
    @error_messages = []
    @selected_campaign_id = campaign_id
    perform_conversion
  end

  def ok?
    @error_messages.empty?
  end

  def equipment_category_id
    @params[:equipment_category_id]
  end

  private

  def perform_conversion
    convert_new_equipment_category_name
    convert_freeform_text_to_equipment_types
  end

  def convert_one_line_to_equipment_type(line)
    eq = EquipmentType.parse(line, @params[:equipment_category_id] )
    eq.campaign_id = @selected_campaign_id
    @equipment_types << eq
    add_any_error_messages line, eq
  end

  def add_any_error_messages raw_text, parsed_equipment_type
    if ! parsed_equipment_type.valid?
      msg = "'#{raw_text}' has errors: "
      msg += parsed_equipment_type.errors.full_messages.to_s
      @error_messages << msg
    end
  end

  def convert_freeform_text_to_equipment_types
    @params[:freeform_text].to_s.split("\n").each do |line|
      clean_line = line.strip
      convert_one_line_to_equipment_type clean_line if clean_line.present?
    end
  end

  def whitelisted_params(params)
    params.permit( permitted_attributes )
  end

  def permitted_attributes
    [ :freeform_text, :equipment_category_id, :equipment_category_name, :campaign_id ]
  end
end
