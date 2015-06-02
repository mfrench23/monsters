module JavascriptVariablesHelper
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
end
