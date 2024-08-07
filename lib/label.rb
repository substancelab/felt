# frozen_string_literal: true

require "felt/configurable"
require "felt/translatable"
require "view_component"

module Felt
  # Renders a label element for a form input.
  class Label < ViewComponent::Base
    include Felt::Configurable
    include Felt::Translatable

    attr_reader :attribute, :form, :options

    # Returns the classes to use for the label element
    def classes
      @classes || classes_from_configuration(:label, :default, :default)
    end

    # - classes: Classes to add to the label element.
    #
    # - text: The label text to show. If not provided, the text will be
    #   looked up in the `felt.<object_name>.<attribute>` translation. See
    #   #label for more details. To not render the label, pass false.
    #
    # All remaining keyword arguments are passed to the label element. See
    # ActionView::Helpers::FormBuilder#label for details.
    def initialize(attribute:, form:, classes: nil, text: nil, **options)
      @attribute = attribute
      @classes = classes
      @form = form
      @text = text
      @options = options
    end

    def render?
      @text != false
    end

    # Returns the text to render in the label. If no text is configured, returns
    # nil.
    #
    # Label texts are looked up in the following order:
    #
    # 1. The text argument passed to the component. Pass +false+ to not render
    #    the label.
    # 2. The `label` key in the `felt.<object_name>.<attribute>` translation.
    # 3. The translation value found under
    #    `helpers.label.<modelname>.<attribute>` (like with
    #    ActionView::Helpers::FormBuilder#label).
    def text
      @text ||= translate("label")
    end

    # Returns true if the input group has a label text configured
    def text?
      text.present?
    end

    private

    def translation_scope
      [:felt, form.object_name, attribute].join(".")
    end
  end
end
