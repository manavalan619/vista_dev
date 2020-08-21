after 'questions:hotel' do
  category = Category.find_by(title: 'Room')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Ground floor' },
      { title: 'First floor' },
      { title: 'Second floor' },
      { title: 'Top floor' }
    ]
  ).find_or_create_by(title: 'What floor do you want your room on?')

  puts "Finished seeding Room questions"
end
