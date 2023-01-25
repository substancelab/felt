require "render_helpers"

module Felt
  module InputGroup
    module CommonBehavior
      include RenderHelpers

      def test_renders_a_label
        render_component_to_html

        assert_selector("label[for=#{@expected_input_id}]", text: @attribute.to_s.titlecase)
      end

      def test_renders_provided_label
        @options = {label: "This label"}

        render_component_to_html

        assert_selector("label[for=#{@expected_input_id}]", text: "This label")
      end

      def test_it_does_not_include_a_label_inside_the_label
        render_component_to_html

        refute_selector("label label")
      end

      def test_renders_an_input_field
        render_component_to_html

        assert_selector("input[type='#{@expected_input_type}'][name='#{@expected_input_name}']")
      end

      def test_uses_classes_configured_for_all_inputs
        Felt.configure do |config|
          config.classes = {
            input: {
              default: {
                default: "default-input-field"
              }
            }
          }
        end

        render_component_to_html

        assert_selector("input.default-input-field")
      end

      def test_uses_classes_configured_for_this_input_type
        Felt.configure do |config|
          config.classes = {
            input: {
              default: {
                default: "default-input-field"
              },
              "#{@component_class.config_key}": {
                default: "specific-input-field"
              }
            }
          }
        end

        render_component_to_html

        assert_selector("input.specific-input-field")
      end

      def test_uses_classes_configured_for_all_inputs_in_invalid_state
        @model.errors.add(@attribute, :invalid)

        Felt.configure do |config|
          config.classes = {
            input: {
              default: {
                invalid: "default-input-field-with-error"
              }
            }
          }
        end

        render_component_to_html

        assert_selector("input.default-input-field-with-error")
      end

      def test_uses_classes_configured_for_this_input_type_in_invalid_state
        @model.errors.add(@attribute, :invalid)

        Felt.configure do |config|
          config.classes = {
            input: {
              "#{@component_class.config_key}": {
                invalid: "specific-input-field-with-error"
              }
            }
          }
        end

        render_component_to_html

        assert_selector("input.specific-input-field-with-error")
      end

      def test_renders_help_from_arguments
        @options = {help: "This has priority over translations"}

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

        assert_text("This has priority over translations")
      end

      def test_renders_help_from_translations
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

        assert_text("Help from translations")
      end

      def test_renders_hint_from_translations
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

        assert_text("Hint from translations")
      end

      def test_renders_errors_if_any
        @model.errors.add(@attribute, :invalid)

        render_component_to_html

        assert_text("is invalid")
      end

      def test_options_can_be_added_to_wrapping_element
        @options = {id: "a-unique-dom-id"}

        render_component_to_html

        assert_css("div#a-unique-dom-id")
      end

      def test_known_options_are_not_added_to_wrapping_element
        render_component_to_html

        refute_css("div[form]")
        refute_css("div[attribute]")
      end

      def test_uses_configured_classes_for_wrapping_element
        Felt.configure do |config|
          config.classes = {
            input_group: {
              "#{@component_class.config_key}": "my-input-group"
            }
          }
        end

        render_component_to_html

        assert_css("div.my-input-group")
      end

      def test_passes_input_options_to_input
        @options = {input_options: {autofocus: true}}

        render_component_to_html

        assert_selector("input[type='#{@expected_input_type}'][autofocus]")
      end

      private

      def with_translations(translations)
        I18n.backend.translations[I18n.locale] = translations
        yield
      ensure
        I18n.reload!
        I18n.eager_load!
      end
    end
  end
end