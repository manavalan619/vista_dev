require 'rails_helper'

RSpec.describe 'admin/questions/index', type: :view do
  before(:each) do
    assign(:questions, Kaminari.paginate_array(create_list(:question, 2, :text)).page(1))
    view.lookup_context.view_paths.unshift 'app/views/admin'
  end

  it 'renders a list of questions' do
    render
    assert_select 'tr>th', text: 'Category'
    assert_select 'tr>th', text: 'Title'
    assert_select 'tr>th', text: 'Kind'
    assert_select 'tr>th', text: 'Intro'
  end
end
