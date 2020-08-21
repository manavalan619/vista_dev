# crumb :admin_root do
#   link 'Home', admin_root_path
# end

crumb :admin_cities do
  link 'Cities', admin_cities_path
end

crumb :admin_city do |city|
  link city.title, admin_city_path(city)
  parent :admin_cities
end

crumb :admin_new_city do |city|
  link 'New city', new_admin_city_path
  parent :admin_cities
end

crumb :admin_edit_city do |city|
  link 'Edit city', edit_admin_city_path(city)
  parent :admin_cities
end

crumb :admin_categories do
  link 'Categories', admin_categories_path
end

crumb :admin_category do |category|
  link category.title, admin_category_path(category)
  parent :admin_categories
end

crumb :admin_new_category do |category|
  link 'New category', new_admin_category_path
  parent :admin_categories
end

crumb :admin_edit_category do |category|
  link 'Edit category', edit_admin_category_path(category)
  parent :admin_categories
end

crumb :admin_partner_categories do
  link 'Partner categories', admin_partner_categories_path
end

crumb :admin_partner_category do |category|
  link category.title, admin_partner_category_path(category)
  parent :admin_partner_categories
end

crumb :admin_new_partner_category do |category|
  link 'New category', new_admin_partner_category_path
  parent :admin_partner_categories
end

crumb :admin_edit_partner_category do |category|
  link 'Edit category', edit_admin_partner_category_path(category)
  parent :admin_partner_categories
end

crumb :admin_questions do
  link 'Questions', admin_questions_path
end

crumb :admin_new_question do |question|
  link 'New question', new_admin_question_path
  parent :admin_questions
end

crumb :admin_edit_question do |question|
  link 'Edit question', edit_admin_question_path(question)
  parent :admin_questions
end

crumb :admin_organisations do
  link 'Organisations', admin_organisations_path
end

crumb :admin_organisation do |organisation|
  link organisation.name, [:admin, organisation]
  parent :admin_organisations
end

crumb :admin_new_organisation do |organisation|
  link 'New organisation', new_admin_organisation_path
  parent :admin_organisations
end

crumb :admin_edit_organisation do |organisation|
  link organisation.name, [:edit, :admin, organisation]
  parent :admin_organisations
end

crumb :admin_business_units do |organisation|
  link 'Business units', [:admin, organisation, :business_units]
  parent :admin_organisation, organisation
end

crumb :admin_new_business_unit do |business_unit|
  link 'New business unit', [:new, :admin, business_unit.organisation, :business_unit]
  parent :admin_business_units, business_unit.organisation
end

crumb :admin_edit_business_unit do |business_unit|
  link business_unit.name, [:edit, :admin, business_unit.organisation, business_unit]
  parent :admin_business_units, business_unit.organisation
end

crumb :admin_branches do |business_unit|
  link 'Branches', [:admin, business_unit.organisation, business_unit, :branches]
  parent :admin_edit_business_unit, business_unit
end

crumb :admin_new_branch do |branch|
  link 'New branch', [:new, :admin, branch.business_unit.organisation, branch.business_unit, :branch]
  parent :admin_branches, branch.business_unit
end

crumb :admin_edit_branch do |branch|
  link branch.name, [:edit, :admin, branch.business_unit.organisation, branch.business_unit, branch]
  parent :admin_branches, branch.business_unit
end

crumb :admin_articles do
  link 'Articles', admin_articles_path
end

crumb :admin_article do |article|
  link article.title, admin_article_path(article)
  parent :admin_articles
end

crumb :admin_new_article do |article|
  link 'New article', new_admin_article_path
  parent :admin_articles
end

crumb :admin_edit_article do |article|
  link 'Edit article', edit_admin_article_path(article)
  parent :admin_articles
end

crumb :admin_upload do
  link 'Import categories and questions', admin_upload_index_path
  parent :admin_categories
end

crumb :admin_preference_groups do
  link 'Preference groups', admin_preference_groups_path
end

crumb :admin_preference_group do |preference_group|
  link preference_group.title, admin_preference_group_path(preference_group)
  parent :admin_preference_groups
end

crumb :admin_new_preference_group do |_preference_group|
  link 'New preference group', new_admin_preference_group_path
  parent :admin_preference_groups
end

crumb :admin_edit_preference_group do |preference_group|
  link 'Edit preference group', edit_admin_preference_group_path(preference_group)
  parent :admin_preference_groups
end

crumb :admin_data_imports do
  link 'Data imports', admin_data_imports_path
end

crumb :admin_data_import do |data_import|
  link data_import.file.to_s.split('/').last, admin_data_import_path(data_import)
  parent :admin_data_imports
end

crumb :admin_new_data_import do |data_import|
  link 'New data_import', new_admin_data_import_path
  parent :admin_data_imports
end

crumb :admin_staff_members do |organisation|
  link 'Staff members', [:admin, organisation, :staff_members]
  parent :admin_organisation, organisation
end

crumb :admin_edit_staff_member do |staff_member|
  link 'Edit staff member', edit_admin_staff_member_path(staff_member)
  parent :admin_staff_members
end

crumb :admin_new_staff_member do |staff_member|
  link 'New staff member', new_admin_staff_member_path
  parent :admin_staff_members
end

crumb :admin_branch_managers do
  link 'Branch managers', admin_branch_managers_path
end

crumb :admin_edit_branch_manager do |branch_manager|
  link 'Edit branch manager', edit_admin_branch_manager_path(branch_manager)
  parent :admin_branch_managers
end

crumb :admin_new_branch_manager do |branch_manager|
  link 'New branch manager', new_admin_branch_manager_path
  parent :admin_branch_managers
end

crumb :admin_admins do |organisation|
  link 'Admins', [:admin, organisation, :admins]
  parent :admin_organisation, organisation
end

crumb :admin_edit_admin do |admin|
  link 'Edit admin', [:edit, :admin, admin.organisation, admin]
  parent :admin_admins, admin.organisation
end

crumb :admin_new_admin do |admin|
  link 'New admin', [:new, :admin, admin.organisation, :admin]
  parent :admin_admins, admin.organisation
end

crumb :admin_videos do
  link 'Videos', admin_videos_path
end

crumb :admin_new_video do |video|
  link 'New video', new_admin_video_path
  parent :admin_videos
end

crumb :admin_edit_video do |video|
  link 'Edit video', edit_admin_video_path(video)
  parent :admin_videos
end
