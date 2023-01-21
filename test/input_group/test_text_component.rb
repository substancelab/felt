# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "input_group/text_component"

class Game
  include ActiveModel::API

  attr_accessor :title
end

class Felt::InputGroup::TextComponentTest < ViewComponent::TestCase
  include ViewComponent::TestHelpers

  def test_renders_a_label
    model = Game.new
    form = build_form(model)

    do_render(form)

    assert_selector("label[for=game_title]", text: "Title")
  end

  def test_renders_provided_label
    model = Game.new
    form = build_form(model)

    do_render(form, label: "This label")

    assert_selector("label[for=game_title]", text: "This label")
  end

  def test_renders_an_input_field
    model = Game.new
    form = build_form(model)

    do_render(form)

    assert_selector("input[type='text'][name='game[title]']")
  end

  def test_uses_the_value_from_the_object
    model = Game.new
    model.title = "Dead Cells"
    form = build_form(model)

    do_render(form)

    assert(page.has_field?("game[title]", with: "Dead Cells"))
  end

  def test_renders_hint_from_translations
    model = Game.new
    model.title = "Dead Cells"
    form = build_form(model)

    with_translations({
      forms: {
        game: {
          title: {
            hint: "Hint from translations"
          }
        }
      }
    }) do
      do_render(form)
    end

    assert_text("Hint from translations")
  end

  def test_renders_errors_if_any
    model = Game.new
    model.errors.add(:title, :invalid)
    form = build_form(model)

    do_render(form)

    assert_text("Title is invalid")
  end

  private

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

  def do_render(form, **options)
    component = Felt::InputGroup::TextComponent.new(form: form, attribute: :title, **options)
    render_inline(component).to_html
  end

  def with_translations(translations)
    original_translations = I18n.backend.translations[I18n.locale]
    I18n.backend.translations[I18n.locale] = translations
    yield
  ensure
    I18n.backend.translations[I18n.locale] = original_translations
  end
end
