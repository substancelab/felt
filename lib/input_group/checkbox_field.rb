# frozen_string_literal: true

require "input_group/base"

module Felt
  module InputGroup
    # Checkbox Field renders a checkbox input field with a label and a helper
    # text.
    #
    # The hint text is optional and is rendered before the checkbox.
    class CheckboxField < InputGroup::Base
      class << self
        def config_key
          :checkbox_field
        end
      end
    end
  end
end
