module SpanComponent
  # To avoid deprecation warning, you need to make the wrapper_options explicit
  # even when they won't be used.
  def span(options = {})
    @button ||= begin
      content = options.delete(:content)

      content_tag :span, content, options
    end
  end
end

SimpleForm.include_component(SpanComponent)