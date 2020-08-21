after 'questions:hotel' do
  category = Category.find_by(title: 'Parking')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Yes' },
      { title: 'No' }
    ]
  ).find_or_create_by(title: 'Are you willing to pay extra for parking?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Valet' },
      { title: 'Self park' }
    ]
  ).find_or_create_by(title: 'Do you prefer valet parking or would you rather park yourself?')

  puts "Finished seeding Parking questions"
end
