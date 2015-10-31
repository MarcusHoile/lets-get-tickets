class DatePickerInput < SimpleForm::Inputs::StringInput 
  def input(wrapper_options)
    value = input_html_options[:value]
    value ||= object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= I18n.localize(value).to_datetime.strftime(::Plan.date_display_format) if value.present?
    input_html_classes << "datetimepicker"

    super # leave StringInput do the real rendering
  end
end
