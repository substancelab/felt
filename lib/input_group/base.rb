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
        @classes ||
          classes_from_configuration(:input_group, config_key)
      end

      def config_key
        raise "Must be implemented in a subclass"
      end

      # Returns the error messages to output in the input group. Returns [] if no
      # errors.
      #
      # This returns the full error messages for the attribute, see
      # ActiveModel::Errors#full_messages for more details.
      def errors
        return [] if form.object.nil?

        form.object.errors.full_messages_for(attribute)
      end

      # Returns true if the input group has errors.
      def errors?
        errors.any?
      end

      # Returns the classes to use for the help text.
      def error_classes
        classes_from_configuration(:error, config_key, state_key) ||
          classes_from_configuration(:error, :default, state_key)
      end

      # Returns the help text for the input group. If no help is configured,
      # returns nil.
      #
      # Help text is looked up in the following order:
      #
      # 1. The help argument passed to the component.
      # 2. The `help` key in the `felt.<object_name>.<attribute>` translation.
      def help
        return false if @help == false

        @help ||=
          translate("help")
      end

      # Returns true if the input group has help configured
      def help?
        help.present?
      end

      # Returns the classes to use for the help text.
      def help_classes
        classes_from_configuration(:help, config_key, state_key) ||
          classes_from_configuration(:help, :default, state_key)
      end

      # Returns the hint for the input group. If no hint is configured, returns
      # nil. If hint has explicitly been set to false, returns false.
      #
      # Hints are looked up in the following order:
      #
      # 1. The hint argument passed to the component.
      # 2. The `hint` key in the `felt.<object_name>.<attribute>` translation.
      def hint
        return false if @hint == false

        @hint ||=
          translate("hint")
      end

      # Returns true if the input group has a hint configured
      def hint?
        hint.present?
      end

      # Returns the classes to use for the hint text.
      def hint_classes
        classes_from_configuration(:hint, config_key, state_key) ||
          classes_from_configuration(:hint, :default, state_key)
      end

      # - classes: CSS classes to add to the wrapping input group element.
      #
      # - help: The help for the input group. If not provided, the help will be
      #   looked up in the `felt.<object_name>.<attribute>` translation. See
      #   #help for more details. To not render a help text, pass +false+.
      #
      # - hint: The hint for the input group. If not provided, the hint will be
      #   looked up in the `felt.<object_name>.<attribute>` translation. See
      #   #hint for more details. To not render a hint, pass +false+.
      #
      # - input_options: The options to pass directly to the input field.
      #
      # - label: The label text for the input group. If not provided, the text
      #   will be looked up in the `felt.<object_name>.<attribute>`
      #   translation. See #label for more details. To not render the label,
      #   pass +false+.
      #
      # - placeholder: The placeholder for the input field. If not provided, the
      #   placeholder will be looked up in the `felt.<object_name>.<attribute>`
      #   translation. See #placeholder for more details. To disable the
      #   placeholder, pass an empty string.
      #
      # All remaining keyword arguments are passed to the wrapping div element
      # of the input group. See ActionView::Helpers::TagHelper#content_tag for
      # details.
      def initialize(attribute:, form:, classes: nil, help: nil, hint: nil, input_options: {}, label: nil, placeholder: nil, **options)
        @attribute = attribute
        @classes = classes
        @form = form
        @help = help
        @hint = hint
        @input_options = input_options
        @label = label
        @options = options
        @placeholder = placeholder
      end

      # Returns the classes to use for the input field.
      def input_classes
        classes_from_configuration(:input, config_key, state_key) ||
          classes_from_configuration(:input, :default, state_key)
      end

      # Returns the classes to use for the label field.
      def label_classes
        classes_from_configuration(:label, config_key, state_key) ||
          classes_from_configuration(:label, :default, state_key)
      end

      # Returns the label for the input group. If no label is configured,
      # returns nil.
      #
      # Labels are looked up in the following order, the first non-nil value is
      # used:
      #
      # 1. The label argument passed to the component.
      # 2. The `label` key in the `felt.<object_name>.<attribute>` translation.
      # 3. The translation value found under
      #    `helpers.label.<modelname>.<attribute>` (like with
      #    ActionView::Helpers::FormBuilder#label).
      #
      # To not render the label, pass +false+ as the label argument.
      def label
        return @label if @label == false

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
      # 2. The `placeholder` key in the `felt.<object_name>.<attribute>`
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

      # Returns classes configured at the given path under the classes key in
      # the configuration.
      def classes_from_configuration(*path)
        Felt.configuration.classes.dig(*path)
      end

      # Returns the key to use as the state part when looking up classes in
      # configuration.
      #
      # Returns `:invalid` if the input group has errors, `:default` otherwise.
      def state_key
        if errors?
          :invalid
        else
          :default
        end
      end

      def translate(key)
        I18n.translate(key, default: nil, scope: translation_scope)
      end

      def translation_scope
        [:felt, form.object_name, attribute].join(".")
      end
    end
  end
end
