class BulmaSelect2Input < SimpleForm::Inputs::CollectionInput
  delegate :content_tag, to: :template

  def input(wrapper_options = nil)
    # input_html_options[:class] = 'file-input'
    # merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @label_method, @value_method = detect_collection_methods

    input_html_options[:class] = 'select2'
    input_html_options[:data] ||= {}
    input_html_options[:data].merge(width: '100%')

    @merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    input_markup
  end

  private

  def input_markup
    content_tag(:div, class: 'field') do
      @builder.collection_select(
        attribute_name, collection, @value_method, @label_method,
        input_options, @merged_input_options
      )
    end
  end
end
