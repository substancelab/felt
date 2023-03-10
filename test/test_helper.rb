# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"

require "rails"
require "rails/test_help"

require "action_controller/railtie"
require "rails/test_unit/railtie"

require "input_group/common_behavior"

require File.expand_path("../demo/config/environment.rb", __dir__)
require "felt"
