# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "i18n_helpers"
require "render_helpers"

require "hint"

class Game
  include ActiveModel::API

  attr_accessor :title
end

class Felt::HintTest < ViewComponent::TestCase
  include I18nHelpers
  include RenderHelpers

  setup do
    @attribute = :title
    @model = Game.new
    @form = build_form(@model)
    @component_class = Felt::Hint

    @expected_input_id = "game_title"
    @expected_input_name = "game[title]"
  end

  test "renders nothing when text is nil" do
    render_component_to_html

    refute_selector("div")
  end

  test "renders hint text from translations" do
    with_translations({
      forms: {
        "#{@form.object_name}": {
          "#{@attribute}": {
            hint: "Hint from translations"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_selector("div", text: "Hint from translations")
  end

  def test_renders_provided_hint
    @options = {text: "Hint text"}

    render_component_to_html

    assert_selector("div", text: "Hint text")
  end

  def test_uses_configured_classes_for_hint
    @options = {text: "Hint text"}
    Felt.configure do |config|
      config.classes = {
        hint: {
          default: {
            default: "default-hint"
          }
        }
      }
    end

    render_component_to_html

    assert_selector("div.default-hint")
  end

  def test_uses_specified_classes
    @options = {classes: "custom-hint", text: "Hint text"}
    Felt.configure do |config|
      config.classes = {
        hint: {
          default: {
            default: "default-hint"
          }
        }
      }
    end

    render_component_to_html

    assert_selector("div.custom-hint")
  end
end
