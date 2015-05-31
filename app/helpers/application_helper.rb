module ApplicationHelper
  def entity_links(method, options = {})
    plural = method.to_s.pluralize.downcase
    list_entries = content_tag("li", index_link(plural) ) +
                     content_tag("li", new_link(method) )
    return content_tag("ul", list_entries, options)
  end

  def javascript_variables(variables = nil)
    @javascript_variables ||= {}
    @javascript_variables.merge!(variables) if !variables.nil?
    return if @javascript_variables == {}
    output_javascript_variables
  end

  private

  def output_javascript_variables
    padding = @javascript_variables.keys.group_by(&:size).max.first
    output = @javascript_variables.reduce('') do | memo, (variable, value) |
      memo << "#{variable.to_s.ljust(padding)} = #{value.to_json},\n          "
    end.strip.html_safe.gsub(/\,\Z/m, ';')
    raw "var #{output}"
  end

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
