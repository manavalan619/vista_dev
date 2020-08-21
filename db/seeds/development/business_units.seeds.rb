after 'development:organisations' do
  business_unit = BusinessUnit.find_or_create_by(name: 'Developer Division')
  business_unit.organisation = Organisation.first
  business_unit.save
end
