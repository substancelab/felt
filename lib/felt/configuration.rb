# frozen_string_literal: true

module Felt
  class Configuration
    attr_accessor :classes

    def initialize
      @classes = {}
    end
  end
end
