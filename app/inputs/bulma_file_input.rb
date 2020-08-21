class BulmaFileInput < SimpleForm::Inputs::Base
  delegate :content_tag, to: :template

  def input(wrapper_options = nil)
    input_html_options[:class] = 'file-input'
    # merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    input_markup
  end

  private

  def translate(key, options = {})
    I18n.translate(['simple_form', key].join('.'))
  end

  def input_markup
    content_tag(:div, class: 'field') do
      @builder.hidden_field(:id) if object.persisted?
      @builder.hidden_field("#{attribute_name}_cache")
      content_tag(:div, class: 'file is-fullwidth has-name is-right') do
        content_tag(:label, class: 'file-label') do
          @builder.file_field(attribute_name, input_html_options) +
          content_tag(:span, class: 'file-cta') do
            content_tag(:span, class: 'file-icon') do
              content_tag(:i, '', class: 'fa fa-upload')
            end +
            content_tag(:span, translate('labels.file.select'), class: 'file-label')
          end +
          existing_file_tag
        end
      end
    end +
    remove_file_button + @builder.error(attribute_name)
  end

  def existing_file_tag
    content_tag(:span, existing_file_name, class: 'file-name')
  end

  def existing_file_name
    return 'No file selected' unless file_exists?

    if object.try(:"#{attribute_name}?")
      object.send(attribute_name).try(:file).try(:filename).html_safe
    elsif (attachment = object.try(attribute_name)).try(:attached?)
      attachment.filename.to_s
    end
  end

  def remove_file_button
    return unless object.send(attribute_name).present?

    content_tag(:label, class: 'label') do
      @builder.check_box(:_destroy, { label: "Remove #{attribute_name}" }, 1, 0) +
      "Remove #{attribute_name}"
    end
  end

  def remove_attachment_method
    options[:remove_method] || :"remove_#{ attribute_name }"
  end

  def file_exists?
    @file_exists ||= begin
      object.try(:"#{ attribute_name }?") ||
        object.try(attribute_name).try(:attached?)
    end
  end

  def file_url
    if object.try(:"#{ attribute_name }?")
      object.send(attribute_name)
    elsif object.try(attribute_name).try(:attached?)
      object.try(attribute_name)
    end
  end
end
