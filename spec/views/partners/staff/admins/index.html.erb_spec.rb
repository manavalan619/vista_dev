require 'rails_helper'

RSpec.describe 'partners/staff/admins/index', type: :view do
  before(:each) do
    assign(:admins, Kaminari.paginate_array(create_list(:admin, 2)))
    view.lookup_context.view_paths.push 'app/views/partners/staff'
  end

  it 'renders a list of admins' do
    render
    assert_select 'tr>th', text: 'Employee ID'
    assert_select 'tr>th', text: 'Name'
    assert_select 'tbody>tr', count: 2
  end
end
