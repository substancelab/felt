require "i18n_helpers"
require "render_helpers"

module Felt
  module InputGroup
    module CommonBehavior
      include I18nHelpers
      include RenderHelpers

      def test_renders_a_label
        render_component_to_html

        assert_selector("label[for=#{@expected_input_id}]", text: @attribute.to_s.titlecase)
      end

      def test_renders_provided_label_text
        @options = {label: "This label"}

        render_component_to_html

        assert_selector("label[for=#{@expected_input_id}]", text: "This label")
      end

      def test_renders_no_label
        @options = {label: false}

        render_component_to_html

        assert_no_selector("label[for=#{@expected_input_id}]")
      end

      def test_it_does_not_include_a_label_inside_the_label
        render_component_to_html

        refute_selector("label label")
      end

      def test_it_uses_classes_configured_for_all_labels
        Felt.configure do |config|
          config.classes = {
            label: {
              default: { # Labels for all input types
                default: "default-label" # Default state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("label[for=#{@expected_input_id}].default-label")
      end

      def test_it_uses_classes_configured_for_labels_for_this_input_type
        Felt.configure do |config|
          config.classes = {
            label: {
              default: { # Labels for all input types
                default: "default-label" # Default state
              },
              "#{@component_class.name.demodulize.underscore}": {
                default: "specific-input-label" # Default state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("label[for=#{@expected_input_id}].specific-input-label")
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
              "#{@component_class.name.demodulize.underscore}": {
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
              "#{@component_class.name.demodulize.underscore}": {
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

      def test_it_uses_classes_configured_for_all_helps
        @options = {help: "This is helpful"}

        Felt.configure do |config|
          config.classes = {
            help: {
              default: { # Help elements for all input types
                default: "default-help" # Default state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("div.default-help")
      end

      def test_it_uses_classes_configured_for_helps_for_this_input_type
        @options = {help: "This is helpful"}

        Felt.configure do |config|
          config.classes = {
            help: {
              default: { # Helps for all input types
                default: "default-help" # Default state
              },
              "#{@component_class.name.demodulize.underscore}": {
                default: "specific-input-help" # Default state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("div.specific-input-help")
      end

      def test_renders_hint_from_arguments
        @options = {hint: "This has priority over translations"}

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

        assert_text("This has priority over translations")
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

      def test_it_uses_classes_configured_for_all_hints
        @options = {hint: "This is a hint"}

        Felt.configure do |config|
          config.classes = {
            hint: {
              default: { # Help elements for all input types
                default: "default-hint" # Default state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("div.default-hint")
      end

      def test_it_uses_classes_configured_for_hints_for_this_input_type
        @options = {hint: "This is hintful"}

        Felt.configure do |config|
          config.classes = {
            hint: {
              default: { # hints for all input types
                default: "default-hint" # Default state
              },
              "#{@component_class.name.demodulize.underscore}": {
                default: "specific-input-hint" # Default state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("div.specific-input-hint")
      end

      def test_renders_errors_if_any
        @model.errors.add(@attribute, :invalid)

        render_component_to_html

        assert_text("is invalid")
      end

      def test_it_uses_classes_configured_for_all_errors
        @model.errors.add(@attribute, :invalid)

        Felt.configure do |config|
          config.classes = {
            error: {
              default: { # Help elements for all input types
                invalid: "default-error" # Errors are usually shown in the invalid state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("p.default-error")
      end

      def test_it_uses_classes_configured_for_errors_for_this_input_type
        @model.errors.add(@attribute, :invalid)

        Felt.configure do |config|
          config.classes = {
            error: {
              default: { # errors for all input types
                invalid: "default-error" # Default state
              },
              "#{@component_class.name.demodulize.underscore}": {
                invalid: "specific-input-error" # Errors are usually shown in the invalid state
              }
            }
          }
        end

        render_component_to_html

        assert_selector("p.specific-input-error")
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

      def test_uses_classes_from_argument_for_wrapping_element
        @options = {classes: "class-from-argument"}
        Felt.configure do |config|
          config.classes = {
            input_group: {
              "#{@component_class.name.demodulize.underscore}": "my-input-group"
            }
          }
        end

        render_component_to_html

        assert_css("div.class-from-argument")
      end

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

      def test_passes_input_options_to_input
        @options = {input_options: {autofocus: true}}

        render_component_to_html

        assert_selector("input[type='#{@expected_input_type}'][autofocus]")
      end
    end
  end
end
