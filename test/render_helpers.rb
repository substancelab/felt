module RenderHelpers
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

  # Expects the following instance variables to be set:
  #
  # - @attribute
  # - @form
  # - @component_class
  # - @options
  def render_component_to_html
    component = @component_class.new(
      form: @form,
      attribute: @attribute,
      **(@options || {})
    )
    render_inline(component).to_html
  end
end
