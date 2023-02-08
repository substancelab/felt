# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "input_group/checkbox_field"

class Game
  include ActiveModel::API

  attr_accessor :released
end

class Felt::InputGroup::CheckboxFieldTest < ViewComponent::TestCase
  setup do
    @attribute = :released
    @model = Game.new
    @form = build_form(@model)
    @component_class = Felt::InputGroup::CheckboxField

    @expected_input_id = "game_released"
    @expected_input_name = "game[released]"
    @expected_input_type = "checkbox"
  end

  include Felt::InputGroup::CommonBehavior

  def test_defaults_the_value_to_1
    @model.send("#{@attribute}=", "Something entirely different")

    render_component_to_html

    assert(page.has_field?(@expected_input_name, with: "1"))
  end

  def test_accepts_a_specific_checked_value
    @options = {input_options: {checked_value: "This value"}}

    render_component_to_html

    assert(page.has_field?(@expected_input_name, with: "This value"))
  end

  def test_checks_the_checkbox_if_value_is_truthy
    @model.send("#{@attribute}=", true)

    render_component_to_html

    assert_selector("input[type='checkbox'][checked='checked']")
    assert(page.has_field?(@expected_input_name, with: "1"))
  end

  def test_unchecks_the_checkbox_if_value_is_falsey
    @model.send("#{@attribute}=", false)

    render_component_to_html

    refute_selector("input[type='checkbox'][checked='checked']")
  end
end
