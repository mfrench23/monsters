module ActionView
  module Helpers
    module FormHelper
      def form_for_with_custom(record, options = {}, &proc)
        options[:builder] = MonsterFormBuilder
        form_for_without_custom(record, options, &proc)
      end

      def fields_for_with_custom(record_name, record_object = nil, options = {}, &block)
        options[:builder] = MonsterFormBuilder
        fields_for_without_custom(record_name, record_object, options, &block)
      end

      alias_method_chain :form_for, :custom
      alias_method_chain :fields_for, :custom
    end
  end
end
