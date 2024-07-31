# frozen_string_literal: true

require_relative "felt/configuration"
require_relative "felt/version"

require_relative "input_group/checkbox_field"
require_relative "input_group/email_field"
require_relative "input_group/password_field"
require_relative "input_group/text_field"
require_relative "input_group/wrapper"
require_relative "help"
require_relative "hint"
require_relative "label"

module Felt
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
