after 'development:organisations' do
  admin = Admin.find_or_create_by(email: 'a@a.com')
  admin.organisation = Organisation.first
  admin.password = 'Password123'
  # admin.password_confirmation = 'Password123'
  admin.first_name = 'Admin'
  admin.last_name = 'User'
  admin.confirmed_at = Time.now.utc
  admin.employee_id = 'Admin123'
  admin.save
end
