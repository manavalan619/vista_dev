require 'rails_helper'

RSpec.describe 'partners/roles/index', type: :view do
  let(:user) { create(:branch_manager) }
  let(:business_unit) { user.assigned_business_units.first }
  let(:roles) { create_list(:role, 2, business_unit: business_unit) }

  before(:each) do
    assign(:business_unit, business_unit)
    assign(:roles, Kaminari.paginate_array(roles).page(1))
    allow(view).to receive(:current_staff_member).and_return(user)
    view.lookup_context.view_paths.push 'app/views/partners'
    view.lookup_context.view_paths.push 'app/views/partners/base'
  end

  it 'renders a list of partners/roles' do
    render
    assert_select 'tbody>tr', count: 2
  end
end
