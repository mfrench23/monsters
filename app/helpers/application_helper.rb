module ApplicationHelper
  def entity_links(method, options = {})
    plural = method.to_s.pluralize.downcase

    itext = "List All " + plural.titleize
    index_url = send(plural + "_path")
    index_link = link_to itext.to_s, index_url

    ntext = "New " + method.to_s.titleize
    new_url = send("new_" + method.to_s.downcase + "_path")
    new_link = link_to ntext.to_s, new_url

    list_entries = content_tag("li", index_link ) +
                     content_tag("li", new_link )
    return content_tag("ul", list_entries, options)
  end
end
