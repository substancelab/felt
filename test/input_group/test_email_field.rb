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
  include ViewComponent::TestHelpers

  setup do
    @attribute = :email
    @model = Subscriber.new
    @form = build_form(@model)
    @component_class = Felt::InputGroup::EmailField
  end

  def test_renders_a_label
    render_component_to_html

    assert_selector("label[for=subscriber_email]", text: "Email")
  end

  def test_renders_provided_label
    @options = {label: "This label"}
    render_component_to_html

    assert_selector("label[for=subscriber_email]", text: "This label")
  end

  def test_renders_an_input_field
    render_component_to_html

    assert_selector("input[type='email'][name='subscriber[email]']")
  end

  def test_uses_the_value_from_the_object
    @model.email = "mario@nintendo.com"

    render_component_to_html

    assert(page.has_field?("subscriber[email]", with: "mario@nintendo.com"))
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

    assert_selector("input[type='email'].input-field")
  end

  def test_renders_help_from_arguments
    @options = {help: "This has priority over translations"}

    with_translations({
      forms: {
        subscriber: {
          email: {
            help: "Help from translations"
          }
        }
      }
    }) do
      render_component_to_html
    end

    assert_text("This has priority over translations")
  end

  def test_renders_help_from_translations
    with_translations({
      forms: {
        subscriber: {
          email: {
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
    with_translations({
      forms: {
        subscriber: {
          email: {
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
    @model.errors.add(:email, :invalid)

    render_component_to_html

    assert_text("Email is invalid")
  end

  def test_uses_error_classes_if_model_is_invalid
    @model.errors.add(:email, :invalid)

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

    assert_css("input[type=email].error-class")
  end

  def test_options_can_be_added_to_wrapping_element
    @options = {id: "subscriber-card"}
    render_component_to_html

    assert_css("div#subscriber-card")
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

  private

  def build_form(model)
    ActionView::Helpers::FormBuilder.new(
      model.class.to_s.underscore,
      model,
      build_template,
      {}
    )
  end

  def build_template
    ActionView::Base.new(
      :this,
      {}, # assigns?
      :there
    )
  end

  def do_render(form, **options)
    component = Felt::InputGroup::EmailField.new(form: form, attribute: :email, **options)
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

  def with_translations(translations)
    original_translations = I18n.backend.translations[I18n.locale]
    I18n.backend.translations[I18n.locale] = translations
    yield
  ensure
    I18n.backend.translations[I18n.locale] = original_translations
  end
end
