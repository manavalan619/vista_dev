after 'development:partner_categories' do
  unless Branch.any?
    business_unit = BusinessUnit.find_by(name: 'Developer Division')
    partner_category = PartnerCategory.find_by(title: 'My First Partner Category')
    FactoryBot.create_list(:branch, 20,
                           business_unit: business_unit,
                           vista_partner: true,
                           categories: [partner_category])
  end
end
