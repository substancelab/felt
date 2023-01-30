module I18nHelpers
  def with_translations(translations)
    I18n.backend.translations[I18n.locale] = translations
    yield
  ensure
    I18n.reload!
    I18n.eager_load!
  end
end
