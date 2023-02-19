# frozen_string_literal: true

require "view_component"

module Felt
  # Renders a hint element for a form input.
  class Hint < ViewComponent::Base
    attr_reader :attribute, :form, :options

    # Returns the classes to use for the hint element
    def classes
      @classes ||
        Felt.configuration.classes.dig(:hint, :default, :default)
    end

    # - classes: Classes to add to the hint element.
    #
    # - text: The hint text to show. If not provided, the text will be looked up
    #   in the `forms.<object_name>.<attribute>` translation. See #hint for more
    #   details. To not render the hint, pass +false+ (or any object that
    #   responds +true+ to +blank?+).
    #
    # All remaining keyword arguments are passed to the hint element. See
    # ActionView::Helpers::FormBuilder#hint for details.
    def initialize(attribute:, form:, classes: nil, text: nil, **options)
      @attribute = attribute
      @classes = classes
      @form = form
      @text = text
      @options = options
    end

    def render?
      return false if @text == false

      text.present?
    end

    # Returns the text to render in the hint. If no text is configured, returns
    # nil.
    #
    # Hint texts are looked up in the following order:
    #
    # 1. The text argument passed to the component. Pass +false+ to not render
    #    the hint element.
    # 2. The `hint` key in the `forms.<object_name>.<attribute>` translation.
    # 3. The translation value found under
    #    `helpers.hint.<modelname>.<attribute>` (like with
    #    ActionView::Helpers::FormBuilder#hint).
    def text
      return false if @text == false

      @text ||= translate("hint")
    end

    # Returns true if the input group has a hint text configured
    def text?
      text.present?
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
