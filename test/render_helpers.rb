module RenderHelpers
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
