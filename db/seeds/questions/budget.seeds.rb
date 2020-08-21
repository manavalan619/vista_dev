after 'questions:hotel' do
  category = Category.find_by(title: 'Budget')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Less than $1000' },
      { title: '$1000-5000' },
      { title: '$5000-10000' },
      { title: 'Above $10000' }
    ]
  ).find_or_create_by(title: 'How much do you plan to spend during your visit at the hotel on restaurants/cafes?')

  puts "Finished seeding Budget questions"
end
