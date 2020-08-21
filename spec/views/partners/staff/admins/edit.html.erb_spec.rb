require 'rails_helper'

RSpec.describe 'partners/staff/admins/edit', type: :view do
  before(:each) do
    @admin = assign(:admin, create(:admin))
  end

  it 'renders the edit admin form' do
    render

    assert_select 'form[action=?][method=?]', url_for([:partners, @admin]), 'post' do
      assert_select 'input[name=?]', 'admin[first_name]'
      assert_select 'input[name=?]', 'admin[last_name]'
      assert_select 'input[name=?]', 'admin[email]'
      assert_select 'input[name=?]', 'admin[mobile_number]'
      assert_select 'input[name=?]', 'admin[employee_id]'
    end
  end
end
