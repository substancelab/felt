# frozen_string_literal: true

require "view_component"

module Felt
  module InputGroup
    # Renders a stacked input group element. This is the base class for all input
    # groups and should not be instantiated directly.
    class Base < ViewComponent::Base
      attr_reader :attribute, :form, :input_options, :options

      # Returns the classes to use for the root element of the input.
      def classes
        Felt.configuration.classes.dig(:input_group, :text_field)
      end

      # Returns the error messages to output in the input group. Returns [] if no
      # errors.
      #
      # This returns the full error messages for the attribute, see
      # ActiveModel::Errors#full_messages for more details.
      def errors
        form.object.errors.full_messages_for(attribute)
      end

      # Returns true if the input group has errors.
      def errors?
        errors.any?
      end

      # Returns the help text for the input group. If no help is configured,
      # returns nil.
      #
      # Help text is looked up in the following order:
      #
      # 1. The help argument passed to the component.
      # 2. The `help` key in the `forms.<object_name>.<attribute>` translation.
      def help
        @help ||=
          translate("help")
      end

      # Returns true if the input group has a hint configured
      def help?
        help.present?
      end

      # Returns the hint for the input group. If no hint is configured, returns nil.
      #
      # Hints are looked up in the following order:
      #
      # 1. The hint argument passed to the component.
      # 2. The `hint` key in the `forms.<object_name>.<attribute>` translation.
      def hint
        @hint ||=
          translate("hint")
      end

      # Returns true if the input group has a hint configured
      def hint?
        hint.present?
      end

      # - hint: The hint for the input group. If not provided, the hint will be
      #   looked up in the `forms.<object_name>.<attribute>` translation. See
      #   #hint for more details. To disable the hint, pass an empty string.
      #
      # - input_options: The options to pass directly to the input field.
      #
      # - label: The label text for the input group. If not provided, the text
      #   will be looked up in the `forms.<object_name>.<attribute>`
      #   translation. See #label for more details. To disable the label, pass
      #   an empty string.
      #
      # - placeholder: The placeholder for the input field. If not provided, the
      #   placeholder will be looked up in the `forms.<object_name>.<attribute>`
      #   translation. See #placeholder for more details. To disable the
      #   placeholder, pass an empty string.
      #
      # All remaining keyword arguments are passed to the wrapping div element
      # of the input group. See ActionView::Helpers::TagHelper#content_tag for
      # details.
      def initialize(attribute:, form:, help: nil, hint: nil, input_options: {}, label: nil, placeholder: nil, **options)
        @attribute = attribute
        @form = form
        @help = help
        @hint = hint
        @input_options = input_options
        @label = label
        @options = options
        @placeholder = placeholder
      end

      # Returns the classes to use for the input field. Use configuration from
      # `input_group.input.invalid` if the input group has errors,
      # `input_group.input.default` otherwise.
      def input_classes
        key = if errors?
          :invalid
        else
          :default
        end

        Felt.configuration.classes.dig(:input_group, :input, key)
      end

      # Returns the label for the input group. If no label is configured, returns
      # nil.
      #
      # Labels are looked up in the following order:
      #
      # 1. The label argument passed to the component.
      # 2. The `label` key in the `forms.<object_name>.<attribute>` translation.
      # 3. The translation value found under `helpers.label.<modelname>.<attribute>`
      #    (like with ActionView::Helpers::FormBuilder#label).
      def label
        @label ||=
          translate("label")
      end

      # Returns true if the input group has a label configured
      def label?
        label.present?
      end

      # Returns the placeholder for the input group. If no placeholder is
      # configured, returns nil.
      #
      # Placeholders are looked up in the following order:
      #
      # 1. The placeholder argument passed to the component.
      # 2. The `placeholder` key in the `forms.<object_name>.<attribute>`
      #    translation.
      def placeholder
        @placeholder ||=
          translate("placeholder")
      end

      # Returns true if the input group has a placeholder configured
      def placeholder?
        placeholder.present?
      end

      private

      def translate(key)
        I18n.translate(key, default: nil, scope: translation_scope)
      end

      def translation_scope
        [:forms, form.object_name, attribute].join(".")
      end
    end
  end
end
