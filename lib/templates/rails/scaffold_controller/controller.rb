<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
# Controller functionality specific to the <%= singular_table_name.classify %> model
class <%= controller_class_name %>Controller < ModelBasedController

  private

  def whitelisted_entity_params
    <%- if attributes_names.empty? -%>
    params.fetch([:<%= singular_table_name %>], {})
    <%- else -%>
    params.fetch(:<%= singular_table_name %>, {}).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
  end
end
<% end -%>
