# frozen_string_literal: true

require "view_component"

module Felt
  # Renders a help element for a form input.
  class Help < ViewComponent::Base
    attr_reader :attribute, :form, :options

    # Returns the classes to use for the help element
    def classes
      @classes ||
        Felt.configuration.classes.dig(:help, :default, :default)
    end

    # - classes: Classes to add to the help element.
    #
    # - text: The help text to show. If not provided, the text will be looked up
    #   in the `forms.<object_name>.<attribute>` translation. See #help for more
    #   details. To not render the hint, pass +false+ (or any object that
    #   responds +true+ to +blank?+).
    #
    # All remaining keyword arguments are passed to the help element. See
    # ActionView::Helpers::FormBuilder#help for details.
    def initialize(attribute:, form:, classes: nil, text: nil, **options)
      @attribute = attribute
      @classes = classes
      @form = form
      @text = text
      @options = options
    end

    def render?
      text.present?
    end

    # Returns the text to render in the help. If no text is configured, returns
    # nil.
    #
    # Help texts are looked up in the following order:
    #
    # 1. The text argument passed to the component. Pass +false+ to not render
    #    the help element.
    # 2. The `help` key in the `forms.<object_name>.<attribute>` translation.
    # 3. The translation value found under
    #    `helpers.help.<modelname>.<attribute>` (like with
    #    ActionView::Helpers::FormBuilder#help).
    def text
      return false if @text == false

      @text ||= translate("help")
    end

    # Returns true if the input group has a help text configured
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
