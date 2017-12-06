module IndexHelper
  def edit_destroy_links(target)
    capture do
      concat( content_tag(:td, :class => "index_edit_link") do
        link_to 'Edit', edit_polymorphic_path(target)
      end )
      concat( content_tag(:td, :class => "index_destroy_link") do
        link_to 'Destroy', target, method: :delete, data: { confirm: 'Are you sure?' }
      end )
    end
  end
end
