module TopNavHelper
  def entity_links(method, options = {})
    plural = method.to_s.pluralize.downcase
    list_entries = content_tag("li", index_link(plural) ) +
                     content_tag("li", new_link(method) )
    return content_tag("ul", list_entries, options)
  end

  private

  def index_link(plural)
    itext = "List All " + plural.to_s.titleize
    index_url = send(plural.to_s + "_path")
    index_link = link_to itext.to_s, index_url
  end

  def new_link(method)
    ntext = "New " + method.to_s.titleize
    new_url = send("new_" + method.to_s.downcase + "_path")
    new_link = link_to ntext.to_s, new_url
  end
end
