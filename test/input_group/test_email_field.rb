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
end
