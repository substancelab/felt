# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "input_group/email_field"

class Subscriber
  include ActiveModel::API

  attr_accessor :email
end

class Felt::InputGroup::EmailFieldTest < ViewComponent::TestCase
  setup do
    @attribute = :email
    @model = Subscriber.new
    @form = build_form(@model)
    @component_class = Felt::InputGroup::EmailField

    @expected_input_id = "subscriber_email"
    @expected_input_name = "subscriber[email]"
    @expected_input_type = "email"
  end

  include Felt::InputGroup::CommonBehavior

  def test_uses_configured_classes_for_wrapping_element
    Felt.configure do |config|
      config.classes = {
        input_group: {
          "#{@component_class.name.demodulize.underscore}": "my-input-group"
        }
      }
    end

    render_component_to_html

    assert_css("div.my-input-group")
  end

  def test_uses_the_value_from_the_object
    @model.send(:"#{@attribute}=", "Something entirely different")

    render_component_to_html

    assert(page.has_field?(@expected_input_name, with: @model.send(@attribute)))
  end

  def test_uses_a_specified_value
    @options = {input_options: {value: "This value"}}
    render_component_to_html

    assert_selector("input[type='#{@expected_input_type}'][name='#{@expected_input_name}'][value='This value']")
  end
end
