require 'rails_helper'

RSpec.describe 'partners/staff/branch_managers/edit', type: :view do
  before(:each) do
    add_controller_helpers Partners::BaseController
    @branch_manager = assign(:branch_manager, create(:branch_manager))
    allow(view).to receive(:current_organisation).and_return(@branch_manager.organisation)
  end

  it 'renders the edit branch_manager form' do
    render

    assert_select 'form[action=?][method=?]', url_for([:partners, @branch_manager]), 'post' do
      assert_select 'input[name=?]', 'branch_manager[assigned_branch_ids][]'
      assert_select 'input[name=?]', 'branch_manager[employee_id]'
      assert_select 'input[name=?]', 'branch_manager[first_name]'
      assert_select 'input[name=?]', 'branch_manager[last_name]'
      assert_select 'input[name=?]', 'branch_manager[email]'
      assert_select 'input[name=?]', 'branch_manager[mobile_number]'
    end
  end
end
