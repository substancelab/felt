# frozen_string_literal: true

require "input_group/base"

module Felt
  module InputGroup
    class EmailField < InputGroup::Base
      def config_key
        :email_field
      end
    end
  end
end
