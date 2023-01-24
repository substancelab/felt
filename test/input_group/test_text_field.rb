# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "input_group/text_field"

class Game
  include ActiveModel::API

  attr_accessor :title
end

class Felt::InputGroup::TextFieldTest < ViewComponent::TestCase
  include ViewComponent::TestHelpers

  setup do
    @attribute = :title
    @model = Game.new
    @form = build_form(@model)
    @component_class = Felt::InputGroup::TextField
  end

  def test_renders_a_label
    render_component_to_html

    assert_selector("label[for=game_title]", text: "Title")
  end

  def test_renders_provided_label
    @options = {label: "This label"}

    render_component_to_html

    assert_selector("label[for=game_title]", text: "This label")
  end

  def test_renders_an_input_field
    render_component_to_html

    assert_selector("input[type='text'][name='game[title]']")
  end

  def test_uses_the_value_from_the_object
    @model.title = "Dead Cells"

    render_component_to_html

    assert(page.has_field?("game[title]", with: "Dead Cells"))
  end

  def test_uses_configured_classes_for_input
    Felt.configure do |config|
      config.classes = {
        input_group: {
          input: {
            default: "input-field"
          }
        }
      }
    end

    render_component_to_html

    assert_selector("input[type='text'].input-field")
  end

  def test_renders_help_from_arguments
    @options = {help: "Help is shown below the input"}

    with_translations({
      forms: {
        game: {
          title: {
            help: "Help from translations"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_text("Help is shown below the input")
  end

  def test_renders_help_from_translations
    with_translations({
      forms: {
        game: {
          title: {
            help: "Help from translations"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_text("Help from translations")
  end

  def test_renders_hint_from_translations
    @model.title = "Dead Cells"

    with_translations({
      forms: {
        game: {
          title: {
            hint: "Hint from translations"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_text("Hint from translations")
  end

  def test_renders_errors_if_any
    @model.errors.add(:title, :invalid)

    render_component_to_html

    assert_text("Title is invalid")
  end

  def test_uses_error_classes_if_model_is_invalid
    @model.errors.add(:title, :invalid)

    Felt.configure do |config|
      config.classes = {
        input_group: {
          input: {
            invalid: "error-class"
          }
        }
      }
    end

    render_component_to_html

    assert_css("input[type=text].error-class")
  end

  def test_options_can_be_added_to_wrapping_element
    model = Game.new
    form = build_form(model)

    do_render(form, id: "game-card")

    assert_css("div#game-card")
  end

  def test_known_options_are_not_added_to_wrapping_element
    render_component_to_html

    refute_css("div[form]")
    refute_css("div[attribute]")
  end

  def test_uses_configured_classes_for_wrapping_element
    Felt.configure do |config|
      config.classes = {
        input_group: {
          text_field: "my-input-group"
        }
      }
    end

    render_component_to_html

    assert_css("div.my-input-group")
  end

  def test_passes_input_options_to_input
    @options = {input_options: {autofocus: true}}

    render_component_to_html

    assert_selector("input[type='text'][autofocus]")
  end

  private

  def do_render(form, **options)
    component = Felt::InputGroup::TextField.new(form: form, attribute: :title, **options)
    render_inline(component).to_html
  end

  def render_component_to_html
    component = @component_class.new(
      form: @form,
      attribute: @attribute,
      **(@options || {})
    )
    render_inline(component).to_html
  end
end
