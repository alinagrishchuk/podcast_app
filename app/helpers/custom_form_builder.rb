class CustomFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def file_field_button (method, title='select file',options={})
    content_tag :div, class: 'input-btn-wrapper' do
      content_tag(:span, title) +
      file_field(method, options)
    end.concat content_tag(:span,'', class: 'file-name')
  end

end