# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "label"

class Game
  include ActiveModel::API

  attr_accessor :title
end

class Felt::LabelTest < ViewComponent::TestCase
  include RenderHelpers

  setup do
    @attribute = :title
    @model = Game.new
    @form = build_form(@model)
    @component_class = Felt::Label

    @expected_input_id = "game_title"
    @expected_input_name = "game[title]"
  end

  test "renders a label" do
    render_component_to_html

    assert_selector("label[for=#{@expected_input_id}]", text: @attribute.to_s.titlecase)
  end

  def test_renders_provided_label
    @options = {text: "This label"}

    render_component_to_html

    assert_selector("label[for=#{@expected_input_id}]", text: "This label")
  end

  def test_uses_configured_classes_for_label
    Felt.configure do |config|
      config.classes = {
        label: {
          default: "input-field"
        }
      }
    end

    render_component_to_html

    assert_selector("label[for='#{@expected_input_id}'].input-field")
  end

  def test_it_does_not_include_a_label_inside_the_label
    render_component_to_html

    refute_selector("label label")
  end
end
