after 'questions:hotel' do
  category = Category.find_by(title: 'Facilities')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Yes' },
      { title: 'No' }
    ]
  ).find_or_create_by(title: 'Do you want acess to cooking facilities?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Yes' },
      { title: 'No' }
    ]
  ).find_or_create_by(title: 'Do you want access to wifi inside your room?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Reception area' },
      { title: 'Dining area' },
      { title: 'Entertainment area' }
    ]
  ).find_or_create_by(title: 'Where do your prefer your room to be near?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Yes' },
      { title: 'No' },
      { title: 'Don\'t know' }
    ]
  ).find_or_create_by(title: 'Do you want a connecting door suite?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Balcony room' },
      { title: 'Suite' },
      { title: 'Simple room' }
    ]
  ).find_or_create_by(title: 'What room do you prefer?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'No windows' },
      { title: 'Small windows' },
      { title: 'Big windows' }
    ]
  ).find_or_create_by(title: 'Do you prefer room with windows?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Yes' },
      { title: 'No' }
    ]
  ).find_or_create_by(title: 'Do you prefer breakfast in bed?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Hotel restaurant' },
      { title: 'Elsewhere' }
    ]
  ).find_or_create_by(title: 'Do you want to dine in at the hotel restaurant or elsewhere?')

  Question.create_with(
    category: category,
    intro: false,
    kind: 'option',
    answers_attributes: [
      { title: 'Yes' },
      { title: 'No' },
      { title: 'Pay for it' }
    ]
  ).find_or_create_by(title: 'Do you want access to laundry facility or would you rather just pay for it to get done?')

  puts "Finished seeding Facility questions"
end
