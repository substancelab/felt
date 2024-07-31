# frozen_string_literal: true

# Adds a `translate` method to the component that looks up translations. Expects
# a `translation_scope` method to be defined that returns the scope to look up
# translations in for this component.
module Felt::Translatable
  private

  def translate(key)
    I18n.translate(key, default: nil, scope: translation_scope)
  end

  def translation_scope
    raise \
      NotImplementedError,
      "translation_scope must be implemented in the including class"
  end
end
