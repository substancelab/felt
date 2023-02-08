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
  setup do
    @attribute = :title
    @model = Game.new
    @form = build_form(@model)
    @component_class = Felt::InputGroup::TextField

    @expected_input_id = "game_title"
    @expected_input_name = "game[title]"
    @expected_input_type = "text"
  end

  include Felt::InputGroup::CommonBehavior

  def test_uses_the_value_from_the_object
    @model.send("#{@attribute}=", "Something entirely different")

    render_component_to_html

    assert(page.has_field?(@expected_input_name, with: @model.send(@attribute)))
  end

  def test_uses_a_specified_value
    @options = {input_options: {value: "This value"}}
    render_component_to_html

    assert_selector("input[type='#{@expected_input_type}'][name='#{@expected_input_name}'][value='This value']")
  end
end
