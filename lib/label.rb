# frozen_string_literal: true

require "view_component"

module Felt
  # Renders a label element for a form input.
  class Label < ViewComponent::Base
    attr_reader :attribute, :form, :options

    # Returns the classes to use for the label element
    def classes
      Felt.configuration.classes.dig(:label, :default)
    end

    # - label: The label text to show. If not provided, the label will be
    #   looked up in the `forms.<object_name>.<attribute>` translation. See
    #   #label for more details. To disable the label, pass an empty string.
    #
    # All remaining keyword arguments are passed to the label element. See
    # ActionView::Helpers::FormBuilder#label for details.
    def initialize(attribute:, form:, label: nil, **options)
      @attribute = attribute
      @form = form
      @label = label
      @options = options
    end

    # Returns the text to render in the label. If no label is configured,
    # returns nil.
    #
    # Labels are looked up in the following order:
    #
    # 1. The label argument passed to the component.
    # 2. The `label` key in the `forms.<object_name>.<attribute>` translation.
    # 3. The translation value found under
    #    `helpers.label.<modelname>.<attribute>` (like with
    #    ActionView::Helpers::FormBuilder#label).
    def label
      @label ||= translate("label")
    end

    # Returns true if the input group has a label configured
    def label?
      label.present?
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
