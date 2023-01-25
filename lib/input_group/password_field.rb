# frozen_string_literal: true

require "input_group/base"

module Felt
  module InputGroup
    # Renders an input group around a password field. For security reasons this
    # field is blank by default; pass in a value via options if this is not
    # desired.
    class PasswordField < InputGroup::Base
      class << self
        def config_key
          :password_field
        end
      end
    end
  end
end
