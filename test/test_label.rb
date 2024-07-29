# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "support/game"

require "label"

class Felt::LabelTest < ViewComponent::TestCase
  include I18nHelpers
  include RenderHelpers

  setup do
    @attribute = :title
    @model = Game.new
    @form = build_form(@model)
    @component_class = Felt::Label

    @expected_input_id = "game_title"
    @expected_input_name = "game[title]"
  end

  test "renders a label with the attribute name" do
    render_component_to_html

    assert_selector("label[for=#{@expected_input_id}]", text: @attribute.to_s.titlecase)
  end

  test "renders a label with the attribute name when given a blank string" do
    @options = {text: ""}

    render_component_to_html

    assert_selector("label[for=#{@expected_input_id}]", text: @attribute.to_s.titlecase)
  end

  test "renders a label with text from locale in the helpers scope" do
    with_translations({
      helpers: {
        label: {
          game: {
            @attribute => "From helpers"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_selector("label[for=#{@expected_input_id}]", text: "From helpers")
  end

  test "renders a label with text from locale in the activemodel scope" do
    with_translations({
      activemodel: {
        attributes: {
          game: {
            @attribute => "From activemodel"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_selector("label[for=#{@expected_input_id}]", text: "From activemodel")
  end

  def test_renders_provided_label
    @options = {text: "This label"}

    render_component_to_html

    assert_selector("label[for=#{@expected_input_id}]", text: "This label")
  end

  def test_does_not_render
    @options = {text: false}

    render_component_to_html

    refute_selector("label[for=#{@expected_input_id}]")
  end

  def test_uses_configured_classes_for_label
    Felt.configure do |config|
      config.classes = {
        label: {
          default: {
            default: "default-label"
          }
        }
      }
    end

    render_component_to_html

    assert_selector("label[for='#{@expected_input_id}'].default-label")
  end

  def test_uses_specified_classes
    @options = {classes: "custom-label"}
    Felt.configure do |config|
      config.classes = {
        label: {
          default: {
            default: "default-label"
          }
        }
      }
    end

    render_component_to_html

    assert_selector("label[for='#{@expected_input_id}'].custom-label")
  end

  def test_it_does_not_include_a_label_inside_the_label
    render_component_to_html

    refute_selector("label label")
  end
end
