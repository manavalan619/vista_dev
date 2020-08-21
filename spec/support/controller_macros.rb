module ControllerMacros
  def login_vista_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:vista_admin]
      sign_in FactoryBot.create(:vista_admin)
    end
  end

  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end
  end

  def login_staff_member
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:staff_member]
      staff_member = FactoryBot.create(:staff_member)
      sign_in staff_member, scope: :staff_member
    end
  end

  def login_branch_manager
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:branch_manager]
      branch_manager = FactoryBot.create(:branch_manager)
      sign_in branch_manager, scope: :staff_member
    end
  end

  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = FactoryBot.create(:admin, organisation: organisation)
      sign_in admin, scope: :staff_member
    end
  end
end
