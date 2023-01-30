# frozen_string_literal: true

require "input_group/base"

module Felt
  module InputGroup
    # Encapsulates the common functionality of all input groups.
    #
    # Renders a wrapping div containing a label, a hint, an input field, a help
    # element, and a list of errors.
    #
    # Pass the input field as a block to the constructor.
    class Wrapper < Base
      attr_reader :config_key

      def initialize(config_key: nil, **args)
        @config_key = config_key
        super(**args)
      end
    end
  end
end
