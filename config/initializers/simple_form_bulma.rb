# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'notification is-danger'
  config.button_class = 'button'
  config.boolean_label_class = 'checkbox'

  config.wrappers :vertical_form, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'label'

    b.wrapper tag: 'div', class: 'control' do |ba|
      ba.use :input, class: 'input'
    end
    b.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help' }
  end

  config.wrappers :vertical_file_input, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'label'

    b.use :input
    b.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help' }
  end

  config.wrappers :vertical_boolean, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label_input

    b.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help' }
  end

  config.wrappers :vertical_radio_and_checkboxes, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'label'
    b.use :input
    b.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help' }
  end

  config.wrappers :horizontal_form, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-3 label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'input'
      ba.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help' }
    end
  end

  config.wrappers :horizontal_file_input, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help' }
    end
  end

  config.wrappers :horizontal_boolean, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div', class: 'col-sm-offset-3 col-sm-9' do |wr|
      wr.wrapper tag: 'div', class: 'checkbox' do |ba|
        ba.use :label_input
      end

      wr.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
      wr.use :hint,  wrap_with: { tag: 'p', class: 'help' }
    end
  end

  config.wrappers :horizontal_radio_and_checkboxes, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-sm-3 label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help' }
    end
  end

  config.wrappers :inline_form, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: 'input'
    b.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help' }
  end

  config.wrappers :multi_select, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'label'
    b.wrapper tag: 'div', class: 'form-inline' do |ba|
      ba.use :input, class: 'input'
    end
    b.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help' }
  end

  config.wrappers :select, tag: 'div', class: 'field', error_class: 'is-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'label'
    b.wrapper tag: 'div', class: 'control' do |ba|
      ba.wrapper tag: 'div', class: 'select' do |bc|
        bc.use :input, class: 'input'
      end
    end
    b.use :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help' }
  end

  # Wrappers for forms and inputs using the Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
    check_boxes: :vertical_radio_and_checkboxes,
    radio_buttons: :vertical_radio_and_checkboxes,
    file: :vertical_file_input,
    boolean: :vertical_boolean,
    datetime: :multi_select,
    date: :multi_select,
    time: :multi_select,
    select: :select
  }
end
