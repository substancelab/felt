# frozen_string_literal: true

require "input_group/base"

module Felt
  module InputGroup
    # Checkbox Field renders a checkbox input field with a label and a helper
    # text.
    #
    # The hint text is optional and is rendered before the checkbox.
    #
    # http://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html#method-i-check_box
    class CheckboxField < InputGroup::Base
      attr_reader :checked_value

      def config_key
        :checkbox_field
      end

      # In addition to the arguments accepted by InputGroup::Base, CheckboxField
      # accepts the following arguments:
      #
      # - checked_value: The value to use when the checkbox is checked.
      def initialize(attribute:, form:, classes: nil, help: nil, hint: nil, input_options: {}, label: nil, placeholder: nil, **options)
        @checked_value = input_options.delete(:checked_value) || default_checked_value
        super
      end

      private

      def default_checked_value
        "1"
      end
    end
  end
end
