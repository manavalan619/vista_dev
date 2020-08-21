# crumb :partners_root do
#   link 'Home', admin_root_path
# end

crumb :partners_business_units do
  link 'Business units', partners_business_units_path
end

crumb :partners_business_unit do |business_unit|
  link business_unit.name, [:partners, business_unit]
  parent :partners_business_units
end

crumb :partners_new_business_unit do |business_unit|
  link 'New business unit', new_partners_business_unit_path
  parent :partners_business_units
end

crumb :partners_edit_business_unit do |business_unit|
  link 'Edit business unit', edit_partners_business_unit_path
  parent :partners_business_units
end

crumb :partners_branches do |business_unit|
  link 'Branches', [:partners, business_unit, :branches]
  parent :partners_business_unit, business_unit
end

crumb :partners_new_branch do |branch|
  link 'New branch', [:new, :partners, branch.business_unit, :branch]
  parent :partners_branches, branch.business_unit
end

crumb :partners_edit_branch do |branch|
  link 'Edit branch', [:edit, :partners, branch.business_unit, branch]
  parent :partners_branches, branch.business_unit
end

crumb :partners_roles do |business_unit|
  link 'Roles', [:partners, business_unit, :roles]
  parent :partners_business_unit, business_unit
end

crumb :partners_new_role do |role|
  link 'New role', [:new, :partners, role.business_unit, :role]
  parent :partners_roles, role.business_unit
end

crumb :partners_edit_role do |role|
  link 'Edit role', [:edit, :partners, role.business_unit, role]
  parent :partners_roles, role.business_unit
end

crumb :partners_role do |role|
  link role.name, partners_role_path(role)
  parent :partners_roles
end

crumb :partners_staff_members do
  link 'Staff members', partners_staff_members_path
end

crumb :partners_edit_staff_member do |staff_member|
  link 'Edit staff member', edit_partners_staff_member_path(staff_member)
  parent :partners_staff_members
end

crumb :partners_new_staff_member do |staff_member|
  link 'New staff member', new_partners_staff_member_path
  parent :partners_staff_members
end

crumb :partners_branch_managers do
  link 'Branch managers', partners_branch_managers_path
end

crumb :partners_edit_branch_manager do |branch_manager|
  link 'Edit branch manager', edit_partners_branch_manager_path(branch_manager)
  parent :partners_branch_managers
end

crumb :partners_new_branch_manager do |branch_manager|
  link 'New branch manager', new_partners_branch_manager_path
  parent :partners_branch_managers
end

crumb :partners_admins do
  link 'Admins', partners_admins_path
end

crumb :partners_edit_admin do |admin|
  link 'Edit admin', edit_partners_admin_path(admin)
  parent :partners_admins
end

crumb :partners_new_admin do |admin|
  link 'New admin', new_partners_admin_path
  parent :partners_admins
end

crumb :partners_request_types do |business_unit|
  link 'Request Types', [:partners, business_unit, :member_request_types]
  parent :partners_business_unit, business_unit
end

crumb :partners_new_request_type do |request_type|
  link 'New Request Type', [:new, :partners, request_type.business_unit, :member_request_type]
  parent :partners_request_types, request_type.business_unit
end

crumb :partners_edit_request_type do |request_type|
  link 'Edit Request Type', [:edit, :partners, request_type.business_unit, request_type]
  parent :partners_request_types, request_type.business_unit
end
