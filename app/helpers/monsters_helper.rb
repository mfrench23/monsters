module MonstersHelper
  def monster_alias_list(monster)
    monster.monster_names.sort.collect { |x| x.to_s }.join('; ')
  end

  def master_trait_link(master_trait)
    link_to master_trait.name, master_trait, :class => "quiet", :title => master_trait.notes
  end

  def toggle_links(target_id, expand = "expand", hide = "hide")
    toggle_link(target_id, expand) + toggle_link(target_id, hide, true )
  end

  private

  def toggle_link(target_id, text, hidden = false)
    contents = link_to text, "#", :class => "quiet toggle-link blue-highlight", :name => target_id
    content_tag( "span", contents, {:style => "display: " + (hidden ? "none" : "inline-block"), "data-toggle_id" => target_id} )
  end
end
