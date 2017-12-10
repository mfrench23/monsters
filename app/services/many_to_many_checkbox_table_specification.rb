class ManyToManyCheckboxTableSpecification
  attr_reader :subheader_field, :available_intersection_list, :intersection_rows, :subheader_counts,
      :target, :member_name, :intersection_field, :item_hash

  def initialize(props={})
    @subheader_field = props[:subheader_field]
    @available_intersection_list = props[:available_intersection_list]
    @target = props[:target]
    @member_name = props[:member_name]
    @intersection_field = props[:intersection_field]

    intersections = @target.try(@member_name).to_a
    @intersection_rows = []
    @subheader_counts = {}
    @item_hash = {}
    [*@available_intersection_list].each_with_index do |intersected, index|
      intersection_row = intersections.find{ |rw| (rw.try(@intersection_field) == intersected) }
      @intersection_rows << intersection_row
      intersections = intersections - [intersection_row] if intersection_row.present?
      if @subheader_field.present?
        subheader = intersected.try(@subheader_field)
        count = @subheader_counts[subheader] || 0
        count = count + 1 if intersection_row.present?
        @subheader_counts[subheader] = count # subheader_counts = count of SELECTED options

        list = @item_hash[subheader] || []
        list << intersected
        @item_hash[subheader] = list
      end
    end

    @item_hash.keys.each do |key|
      @item_hash[key].sort! { |a,b| a.name <=> b.name }
    end
  end
end