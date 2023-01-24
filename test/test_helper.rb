# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "view_component/test_helpers"

require "rails"
require "rails/test_help"

require "action_controller/railtie"
require "rails/test_unit/railtie"

require "render_helpers"

require File.expand_path("../demo/config/environment.rb", __dir__)
require "felt"

def build_form(model)
  ActionView::Helpers::FormBuilder.new(
    model.class.to_s.underscore,
    model,
    build_template,
    {}
  )
end

def build_template
  ActionView::Base.new(
    :this,
    {}, # assigns?
    :there
  )
end

def with_translations(translations)
  original_translations = I18n.backend.translations[I18n.locale]
  I18n.backend.translations[I18n.locale] = translations
  yield
ensure
  I18n.backend.translations[I18n.locale] = original_translations
end
