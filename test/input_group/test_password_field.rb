# frozen_string_literal: true

require "test_helper"
require "view_component/test_case"
require "active_model"

require "input_group/text_field"

class Account
  include ActiveModel::API

  attr_accessor :number
end

class Felt::InputGroup::PasswordFieldTest < ViewComponent::TestCase
  setup do
    @attribute = :number
    @model = Account.new
    @form = build_form(@model)
    @component_class = Felt::InputGroup::PasswordField

    @expected_input_id = "account_number"
    @expected_input_name = "account[number]"
    @expected_input_type = "password"
  end

  include Felt::InputGroup::CommonBehavior
end
