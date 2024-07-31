# frozen_string_literal: true

# Adds methods to look up classes from the configuration.
module Felt::Configurable
  private

  # Returns classes configured at the given path under the classes key in
  # the configuration.
  def classes_from_configuration(*path)
    Felt.configuration.classes.dig(*path)
  end
end
