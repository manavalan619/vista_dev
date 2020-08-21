require 'rails_helper'

RSpec.describe 'partners/staff/staff_members/new', type: :view do
  before(:each) do
    add_controller_helpers Partners::BaseController
    @staff_member = assign(:staff_member, create(:staff_member))
    allow(view).to receive(:current_organisation).and_return(@staff_member.organisation)
  end

  it 'renders the new staff_member form' do
    render

    assert_select 'form[action=?][method=?]', url_for([:partners, @staff_member]), 'post' do
      assert_select 'input[name=?]', 'staff_member[assigned_branch_ids][]'
      assert_select 'input[name=?]', 'staff_member[employee_id]'
      assert_select 'input[name=?]', 'staff_member[first_name]'
      assert_select 'input[name=?]', 'staff_member[last_name]'
      assert_select 'input[name=?]', 'staff_member[mobile_number]'
      assert_select 'input[name=?]', 'staff_member[pin]'
      assert_select 'input[name=?]', 'staff_member[pin_confirmation]'
    end
  end
end
