# frozen_string_literal: true

require "input_group/base"

module Felt
  module InputGroup
    class TextField < InputGroup::Base
      def config_key
        :text_field
      end
    end
  end
end
