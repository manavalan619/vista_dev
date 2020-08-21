require 'rails_helper'

RSpec.describe 'partners/staff/staff_members/index', type: :view do
  before(:each) do
    assign(:staff_members, Kaminari.paginate_array(create_list(:staff_member, 2)))
    view.lookup_context.view_paths.push 'app/views/partners/staff'
  end

  it 'renders a list of staff_members' do
    render
    assert_select 'tr>th', text: 'Employee ID'
    assert_select 'tr>th', text: 'Name'
    assert_select 'tbody>tr', count: 2
  end
end
