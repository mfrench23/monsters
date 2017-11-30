module AncestorTreeHelper
  def ancestor_tree(monster)
    content_tag( :ul, ancestor_tree_contents(monster), class: "rightsidebar")
  end

  def parent_tree(monster, contents)
    return contents if monster.root?
    parent = monster.parent
    parent_link = (format_show_link parent) + " (ancestor)".html_safe
    new_contents = content_tag(:li, parent_link, class: "rightsidebar") + contents
    parent_tree(parent, new_contents)
  end

  def child_tree(monster)
    child_entries = AncestorTreeHelper.sorted_children(monster).reduce("".html_safe) do |memo, child|
      memo += content_tag(:li, format_show_link(child) + " (descendant)".html_safe, class: "rightsidebar" )
    end
    content_tag( :ul, child_entries )
  end

  private

  def self.sorted_children(monster)
    monster.children.sort { |the_one,the_other| the_one.name.upcase <=> the_other.name.upcase }
  end

  def ancestor_tree_contents(monster)
    self_plus_children = content_tag(:li, monster.name.html_safe + child_tree(monster), class: "rightsidebar")
    return self_plus_children if monster.root?
    parent_tree(monster, content_tag(:ul, self_plus_children ))
  end

  def format_show_link(monster)
    link_to monster.name, monster
  end
end
