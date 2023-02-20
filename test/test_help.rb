# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "i18n_helpers"
require "render_helpers"

require "help"

class Game
  include ActiveModel::API

  attr_accessor :title
end

class Felt::HelpTest < ViewComponent::TestCase
  include I18nHelpers
  include RenderHelpers

  setup do
    @attribute = :title
    @model = Game.new
    @form = build_form(@model)
    @component_class = Felt::Help

    @expected_input_id = "game_title"
    @expected_input_name = "game[title]"
  end

  test "renders nothing when text is nil" do
    render_component_to_html

    refute_selector("div")
  end

  test "renders nothing when text is blank" do
    @options = {text: ""}

    render_component_to_html

    refute_selector("div")
  end

  test "renders nothing when text is false" do
    @options = {text: false}

    render_component_to_html

    refute_selector("div")
  end

  test "renders help text from translations" do
    with_translations({
      forms: {
        "#{@form.object_name}": {
          "#{@attribute}": {
            help: "Help from translations"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_selector("div", text: "Help from translations")
  end

  def test_renders_provided_help
    @options = {text: "Help text"}

    render_component_to_html

    assert_selector("div", text: "Help text")
  end

  def test_uses_configured_classes_for_help
    @options = {text: "Help text"}
    Felt.configure do |config|
      config.classes = {
        help: {
          default: {
            default: "default-help"
          }
        }
      }
    end

    render_component_to_html

    assert_selector("div.default-help")
  end

  def test_uses_specified_classes
    @options = {classes: "custom-help", text: "Help text"}
    Felt.configure do |config|
      config.classes = {
        help: {
          default: {
            default: "default-help"
          }
        }
      }
    end

    render_component_to_html

    assert_selector("div.custom-help")
  end
end
