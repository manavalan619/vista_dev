unless Organisation.any?
  Organisation.find_or_create_by(name: 'Kanso')
  FactoryBot.create_list(:organisation, 20)
end
