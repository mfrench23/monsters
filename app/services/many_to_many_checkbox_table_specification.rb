class ManyToManyCheckboxTableSpecification
  attr_reader :member_name, :item_hash, :total_count, :exclusion_hash

  def initialize(props={})
    subheader_field = props[:subheader_field]
    available_intersection_list = props[:available_intersection_list]
    target = props[:target]
    @member_name = props[:member_name]
    intersection_field = props[:intersection_field]
    @exclusion_hash = props[:exclusion_hash] || {}

    @total_count = available_intersection_list.count

    intersections = target.try(@member_name).try(:includes, intersection_field).to_a
    @item_hash = {}
    [*available_intersection_list].each_with_index do |intersected, index|
      intersection_row = intersections.find{ |rw| (rw.try(intersection_field) == intersected) }
      intersections = intersections - [intersection_row] if intersection_row.present?
      if subheader_field.present?
        subheader = intersected.try(subheader_field)

        group = @item_hash[subheader] || {:count_of_selected => 0, :members => []}

        group[:count_of_selected] = group[:count_of_selected] + 1 if intersection_row.present?
        group[:members] << {:intersection_row_id => intersection_row.try(:id),
                            :checked => intersection_row.present?,
                            :foreign_key_name => (intersection_field.to_s + "_id"),
                            :intersected_id => intersected.id,
                            :display_title => intersected.name,
                            :display_text => intersected.name}

        @item_hash[subheader] = group
      end
    end

    @item_hash.keys.each do |key|
      @item_hash[key][:members].sort! { |a,b| a[:display_text] <=> b[:display_text] }
    end
  end
end